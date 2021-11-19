import { Layout } from "antd";
import React from "react";

const { Content, Footer } = Layout;

export default () => (
  <Layout className="layout">
    <Content style={{ padding: "0 50px" }}>
      <div className="site-layout-content" style={{ margin: "100px auto" }}>
        <h1>Hop Catalog</h1>
      </div>
    </Content>
    <Footer style={{ textAlign: "center" }}>Hi Nate!</Footer>
  </Layout>
);
