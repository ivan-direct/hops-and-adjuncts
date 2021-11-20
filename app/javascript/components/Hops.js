import { Layout, Menu, Breadcrumb } from "antd";

const { Header, Content, Footer } = Layout;

import React, { Component } from "react";
import "./Hops.css";
import { green} from '@ant-design/colors';

class Hops extends Component {
  constructor(props) {
    super(props);
    this.state = {
      hops: [],
    };
  }

  loadHops = () => {
    const url = "api/v1/hops";
    fetch(url)
      .then((data) => {
        if (data.ok) {
          return data.json();
        }
        throw new Error("Network error.");
      })
      .then((data) => {
        data.forEach((hop) => {
          const newEl = {
            key: hop.id,
            id: hop.id,
            name: hop.name,
          };

          this.setState((prevState) => ({
            hops: [...prevState.hops, newEl],
          }));
        });
      })
      .catch((err) => message.error("Error: " + err));
  };

  componentDidMount() {
    this.loadHops();
  }

  render() {
    return (
      <Layout className="layout" style={{ height: "100%" }}>
        <Header style={{background: green[2]}}>
          <div className="logo" />
          <Menu theme="light" mode="horizontal" defaultSelectedKeys={["2"]}>
            {new Array(15).fill(null).map((_, index) => {
              const key = index + 1;
              return <Menu.Item key={key}>{`nav ${key}`}</Menu.Item>;
            })}
          </Menu>
        </Header>
        <Content style={{ padding: "0 50px", background: green[0] }}>
          <Breadcrumb style={{ margin: "16px 0" }}>
            <Breadcrumb.Item>Home</Breadcrumb.Item>
            <Breadcrumb.Item>List</Breadcrumb.Item>
            <Breadcrumb.Item>App</Breadcrumb.Item>
          </Breadcrumb>
          <div className="site-layout-content">
            <h1>Hop Catalog</h1>
            <div>
              {this.state.hops.map((hop) => {
                return (
                  <div key={hop.id}>
                    <h1>{hop.name}</h1>
                  </div>
                );
              })}
            </div>
          </div>
        </Content>
        <Footer style={{ textAlign: "center", background: green[2] }}>
          Hops & Adjuncts ©2021 By ivan_direct
        </Footer>
      </Layout>
    );
  }
}

export default Hops;
