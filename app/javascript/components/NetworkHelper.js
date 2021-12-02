/* eslint-disable import/prefer-default-export */
import axios from "axios";

export function getRequest(url) {
  return axios({
    method: "get",
    url,
    validateStatus: () => true,
  });
}
