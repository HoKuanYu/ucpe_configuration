from flask import Flask, json
from flask_socketio import SocketIO, emit, send
from flask_cors import CORS
from ping import ping
from speed import iperf, speed
from topology import gen_nodes
import random


app = Flask(__name__)
app.config["DEBUG"] = True
CORS(app)
socketio = SocketIO(app, cors_allowed_origins="*")

@app.route('/')
def hello_world():
    return 'Hello, Docker! modify222'

@app.route('/ping/<host>')
def ping_test(host):
    print(ping(host=host))
    return json.dumps(ping(host=host))

@app.route('/topology')
def topology_query():
    # nodes = [['1', '2', '3', '4'], ['1', '3', '4'], ['1', '2', '3'], ['1', '3'], ['2', '3', '4']]
    # return json.dumps(random.choice(nodes))
    return json.dumps(gen_nodes())

@app.route('/speed/<host>')
def speed_test(host):
    return json.dumps(speed(host))

@socketio.on('connect')
def connected_msg():
    # emit('server_response', {'data': msg['data']})
    emit('server_response', {'data': ['connected', 'connected2']})

@socketio.on('speed')
def handle_message(message):
    for result in iperf(message):
        emit('speed', {'data': result})


if __name__ == '__main__':
    # app.run(debug = True, host = '0.0.0.0')
    socketio.run(app, debug=True, host='0.0.0.0', port=5000)
