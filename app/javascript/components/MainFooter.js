import { Layout } from "antd";
import { green } from "@ant-design/colors";
import React, { PureComponent } from "react";

const { Footer } = Layout;

class MainFooter extends PureComponent {
  render() {
    return (
      <Footer style={{ textAlign: "center", background: green[2] }}>
        {"Hops & Adjuncts © "}
        {new Date().getUTCFullYear()}
        {" By ivan_direct"}
      </Footer>
    );
  }
}

export default MainFooter;
