import { Layout, Menu, Breadcrumb } from "antd";

const { Header, Content, Footer } = Layout;

import React, { Component } from "react";
import { Link } from "react-router-dom";
import axios from "axios";
import "./Hops.css";
import { green } from "@ant-design/colors";

class Hops extends Component {
  constructor(props) {
    super(props);
    this.state = {
      hops: [],
    };
  }

  loadHops = () => {
    const url = "api/v1/hops";
    axios
      .get(url)
      .then((response) => {
        const { data } = response;
        data.map((hop) => {
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
      .catch(function (error) {
        console.log(error);
      });
  };

  componentDidMount() {
    this.loadHops();
  }

  render() {
    return (
      <Layout className="layout" style={{ height: "100%" }}>
        <Header style={{ background: green[2] }}>
          <div className="logo" />
          <Menu theme="light" mode="horizontal">
            <Menu.Item key="0">
              <Link style={{ fontSize: "21px", fontWeight: "bolder" }} to="/">
                🍺 Home 🍺
              </Link>
            </Menu.Item>
          </Menu>
        </Header>
        <Content style={{ padding: "0 50px", background: green[0] }}>
          <Breadcrumb style={{ margin: "40px 0" }} />
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
