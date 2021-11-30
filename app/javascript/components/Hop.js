import { Layout, Menu, Breadcrumb, Row, Col } from "antd";

const { Header, Content, Footer } = Layout;

import React, { Component } from "react";
import { Link } from "react-router-dom";
import axios from "axios";
import "./Hops.css";
import { green } from "@ant-design/colors";
// import HopCard from "./HopCard";

class Hop extends Component {
  constructor(props) {
    super(props);
    this.state = {
      hop: { id: null, name: null, rating: null, ranking: null, beers: [] },
    };
    this.params = props.params
    this.url = "/api/v1/hops/" + this.params.id;
  }

  loadHop = () => {
    axios
      .get(this.url)
      .then((response) => {
        const { data } = response;
        const { hop } = data;
        const newEl = {
          key: hop.id,
          id: hop.id,
          name: hop.name,
          rating: hop.rating,
          ranking: hop.ranking,
          beers: hop.beers,
        };
        this.setState({ hop: newEl });
      })
      .catch(function (error) {
        console.log(error);
      });
  };

  componentDidMount() {
    this.loadHop();
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
        <Content
          style={{
            padding: "0 50px",
            background: green[0],
            maxHeight: "800px",
            overflow: "scroll",
            overflowX: "scroll",
          }}
        >
          <Breadcrumb style={{ margin: "40px 0" }} />
          <div className="site-layout-content">
            <Row align="top">
              <Col flex={3}>
                <h1>{this.state.hop.name}</h1>
                <div>Hop Content</div>
              </Col>
              <Col flex={2}>
                <h1>Brewery Name</h1>
                <div>Brewery Address</div>
                <div>Brewery Content</div>
              </Col>
            </Row>
          </div>
        </Content>
        <Footer style={{ textAlign: "center", background: green[2] }}>
          Hops & Adjuncts ©{new Date().getUTCFullYear()} By ivan_direct
        </Footer>
      </Layout>
    );
  }
}

export default Hop;
