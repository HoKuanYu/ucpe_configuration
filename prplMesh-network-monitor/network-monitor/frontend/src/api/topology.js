import axios from "./index";

export function topology_query() {
  return axios.get("/topology");
}
