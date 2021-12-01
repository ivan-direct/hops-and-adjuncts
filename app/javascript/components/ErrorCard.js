import { List } from "antd";
import React, { Component } from "react";

class ErrorCard extends Component {
  constructor(props) {
    super(props);
  }

  render() {
    return (
      <List
        size="small"
        header={<h1>Error</h1>}
        style={{ width: "65%" }}
        bordered
        dataSource={[]}
      />
    );
  }
}

export default ErrorCard;
