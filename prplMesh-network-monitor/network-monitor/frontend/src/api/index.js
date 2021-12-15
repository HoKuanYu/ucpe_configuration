import axios_api from "axios";

let axiosConfig = {
  // xsrfCookieName: "csrftoken",
  // xsrfHeaderName: "X-XSRF-TOKEN",
  // withCredentials: true,
  baseURL:  process.env.VUE_APP_SERVER_URL
};

console.log("axio api " + axiosConfig.baseURL)

let axios = axios_api.create(axiosConfig);

export default axios;
