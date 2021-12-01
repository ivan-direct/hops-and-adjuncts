import axios from "axios";

export function getRequest(url) {
  return axios({
    method: "get",
    url: url,
    validateStatus: () => true,
  });
}