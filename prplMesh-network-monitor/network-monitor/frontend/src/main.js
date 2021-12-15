import Vue from "vue";
import App from "./App.vue";
import router from "./router";
import { BootstrapVue, BootstrapVueIcons } from "bootstrap-vue";

import "bootstrap/dist/css/bootstrap.css";
import "bootstrap-vue/dist/bootstrap-vue.css";

import VueClipboard from "vue-clipboard2";

import VueSocketIO from "vue-socket.io";

export const serverURL = 'VUE_APP_SERVER_URL'

Vue.use(
  new VueSocketIO({
    debug: true,
    connection: process.env.VUE_APP_SERVER_URL, //"http://192.168.1.11:5000",
    vuex: {
      actionPrefix: "SOCKET_",
      mutationPrefix: "SOCKET_"
    }
    // options: { path: "/my-app/" } //Optional options
  })
);

import Trend from "vuetrend";
Vue.use(Trend);

Vue.config.productionTip = false;
Vue.use(BootstrapVue);
Vue.use(BootstrapVueIcons);
Vue.use(require("vue-cookies"));
Vue.use(VueClipboard);


new Vue({
  router,
  render: h => h(App)
}).$mount("#app");
