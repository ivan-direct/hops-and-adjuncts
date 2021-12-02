import { List } from "antd";
import React, { PureComponent } from "react";

class ErrorCard extends PureComponent {
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
