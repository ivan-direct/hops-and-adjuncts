import { Spin } from "antd";
import React, { PureComponent } from "react";

class Spinner extends PureComponent {
  render() {
    return (
      <div className="site-layout-content">
        <div style={{ textAlign: "center", padding: "150px" }}>
          <Spin size="large" />
        </div>
      </div>
    );
  }
}

export default Spinner;
