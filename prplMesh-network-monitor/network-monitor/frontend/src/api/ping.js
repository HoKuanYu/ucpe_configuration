import axios from "./index";

export function ping(host) {
  console.log(axios)
  return axios.get("/ping/" + host);
}
