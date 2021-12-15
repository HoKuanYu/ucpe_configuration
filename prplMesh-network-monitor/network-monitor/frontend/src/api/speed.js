import axios from "./index.js"

export function speed(host) {
  console.log(axios)
  return axios.get("/speed/" + host);
}

