<template>
  <b-container class="container-fluid justify-content-center" fluid>
    <b-row align-h="start">
      <h2 class="title ml-5 my-4">Network Monitor</h2>
    </b-row>

    <b-col cols="3" class="ml-5">
      <b-form-input v-model="host" size="sm"></b-form-input>
    </b-col>

    <b-row class="mx-5 my-3">
      <b-col cols="3" class="mx-3">
        <b-row class="shadow rounded py-5" align-h="center">
          <h3>Speed</h3>
          <b-col cols="12" class="my-3">
            <h1>{{ bw }}</h1>
            <h4><sub>Mbits/sec</sub></h4>
          </b-col>
          <trend
            :data="iperf"
            :gradient="['#6fa8dc', '#42b983', '#2c3e50']"
            auto-draw
            smooth
          >
          </trend>
          <b-col cols="12">
            <b-button
              class="registration-text trigger-btn border-0 rounded-pill"
              size="sm"
              @click="speedButton"
            >
              {{ isSpeedCalling ? 'stop monitor' : 'start monitor' }}
            </b-button>
          </b-col>
        </b-row>

        <b-row class="shadow rounded py-5 mt-5" align-h="center">
          <h3>Connection</h3>
          <trend
            :data="connection"
            :gradient="['#6fa8dc', '#42b983', '#2c3e50']"
            auto-draw
            smooth
          >
          </trend>
          <b-col cols="12">
            <b-button
              class="registration-text trigger-btn border-0 rounded-pill mt-2"
              size="sm"
              @click="pingButton"
            >
              {{ this.pingTimer != null ? 'stop monitor' : 'start monitor' }}
            </b-button>
          </b-col>
        </b-row>
      </b-col>
      <b-col cols="8" class="shadow rounded py-5">
        <b-row class="ml-5">
          <b-col cols="7" class="ml-5 pl-5">
            <h3 class="ml-5">Topology</h3>
          </b-col>
          <b-col cols="3" class="ml-5">
            <b-button
              class="registration-text trigger-btn border-0 rounded-pill ml-5"
              size="sm"
              @click="topologyButton"
            >
              {{ this.topoTimer != null ? 'stop monitor' : 'start monitor' }}
            </b-button>
          </b-col>
        </b-row>

        <d3-network :net-nodes="nodes" :net-links="links" :options="options" />
      </b-col>
    </b-row>
  </b-container>
</template>

<script>
import { ping } from "../api/ping";
import { topology_query } from "../api/topology";
import { speed } from "../api/speed";
import gsap from "gsap";
import D3Network from "vue-d3-network";

export default {
  sockets: {
    connect: function() {
      console.log("socket connected");
    },
    speed: function(data) {
      console.log(
        'this method was fired by the socket server. eg: io.emit("customEmit", data) ' +
          data
      );
      this.iperf.push(parseInt(data.data));
      console.log(this.iperf);
      this.number = parseInt(data.data);
    },
    server_response: function(data) {
      console.log("server_response " + data);
    }
  },
  methods: {
    clickButton: function(data) {
      this.$socket.emit("speed", data);
    },
    /*speedButton: function() {
      if (this.speedTimer != null) {
        clearInterval(this.speedTimer);
        this.speedTimer = null;
      } else {
        this.speedTimer = setInterval(() => {
          speed(this.host).then(res => {
            console.log(res);
      	    this.iperf.push(parseInt(res.data));
      	    this.number = parseInt(res.data);
          });
        }, 5000);
      }
    },*/
    speedButton: async function() {
      if (!this.isSpeedCalling) {
	this.isSpeedCalling = true;
	while(this.isSpeedCalling){	
          const res = await speed(this.host);
      	  this.iperf.push(parseInt(res.data));
      	  this.number = parseInt(res.data);
	}
      }
      else {
	this.isSpeedCalling = false;
      }
    },
    pingButton: function() {
      if (this.pingTimer != null) {
        clearInterval(this.pingTimer);
        this.pingTimer = null;
      } else {
        this.pingTimer = setInterval(() => {
          ping(this.host).then(res => {
            console.log(res);
            this.connection.push(res.data ? 1 : 0);
          });
        }, 2000);
      }
    },
    topologyButton: function() {
      if (this.topoTimer != null) {
        clearInterval(this.topoTimer);
        this.topoTimer = null;
      } else {
        this.topoTimer = setInterval(() => {
          topology_query().then(res => {
            console.log(res);
            this.topology = res.data;
          });
        }, 5000);
      }
    }
  },
  components: {
    D3Network
  },
  computed: {
    bw: function() {
      return this.tweenedNumber.toFixed(0);
    },
    options() {
      return {
        force: 8000,
        size: { w: 700, h: 400 },
        nodeSize: this.nodeSize,
        nodeLabels: true,
        linkLabels: true,
        canvas: false,
        fontSize: 20
      };
    }
  },
  watch: {
    number: function(newValue) {
      gsap.to(this.$data, { duration: 0.25, tweenedNumber: newValue });
    },
    topology: function(newValue) {
      // var new_nodes = [{ id: 5, name: "Controller", _color: "orange" }];
      // for (const i of newValue) {
      //   new_nodes.push({ id: parseInt(i), name: "Agent " + i });
      //   console.log(i);
      // }
      // this.nodes = new_nodes
      // console.log(this.nodes);
      this.links = [];
      if (newValue.includes("1")) {
        this.links.push({
          sid: 1,
          tid: 5,
          _svgAttrs: { "stroke-width": 2, opacity: 1 }
        });
      }
      if (newValue.includes("3")) {
        this.links.push({
          sid: 3,
          tid: 5,
          _svgAttrs: { "stroke-width": 2, opacity: 1 }
        });
      }
      if (newValue.includes("2")) {
        if (newValue.includes("1")) this.links.push({ sid: 1, tid: 2 });
        else if (newValue.includes("3")) this.links.push({ sid: 3, tid: 2 });
      }
      if (newValue.includes("4")) {
        if (newValue.includes("3")) this.links.push({ sid: 3, tid: 4 });
        else if (newValue.includes("1")) this.links.push({ sid: 1, tid: 4 });
      }
    }
  },
  data() {
    return {
      iperf: [],
      connection: [],
      number: 0,
      tweenedNumber: 0,
      host: "",
      pingTimer: null,
      topoTimer: null,
      speedTimer: null,
      isSpeedCalling: false,
      //
      topology: [],
      nodes: [
        { id: 5, name: "Controller", _color: "orange" },
        { id: 1, name: "Agent 1" },
        { id: 2, name: "Agent 2" },
        { id: 3, name: "Agent 3" },
        { id: 4, name: "Agent 4" }
      ],
      links: [
        { sid: 1, tid: 2 },
        { sid: 3, tid: 4 },
        { sid: 1, tid: 5, _svgAttrs: { "stroke-width": 2, opacity: 1 } },
        { sid: 3, tid: 5, _svgAttrs: { "stroke-width": 2, opacity: 1 } }
      ],
      nodeSize: 10,
      canvas: false
    };
  }
};
</script>

<style src="vue-d3-network/dist/vue-d3-network.css"></style>

<style scoped lang="scss">
.registration-text {
  color: var(--primay-text);
}

.container-fluid {
  background: var(--primary-bg);
  height: 100vh;
}

.form-container {
  height: 60vh;
  overflow-y: auto;
  overflow-x: hidden;
}

.title {
  font-size: 40px;
  font-weight: 300;
  color: var(--primary-text);
}

.subtitle {
  font-size: 15px;
  font-weight: 300;
  color: var(--primary-text);
}

.banner {
  font-size: 45px;
  font-weight: bold;
  color: var(--primary-text);
}

.trigger-btn {
  border: none;
  background: var(--primary-text) !important;
  color: #f7f7f3;
  // box-shadow: 6px 6px 12px #cfcfcc, -6px -6px 12px #ffffff;
}
</style>
