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
    this.params = props.params;
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
                <Row>
                  <Col span={24}>
                    <h1>{this.state.hop.name}</h1>
                    <p>Rating: {this.state.hop.rating}</p>
                    <p>Ranking: {this.state.hop.ranking}</p>
                  </Col>
                </Row>
                <Row style={{ paddingTop: "24px" }}>
                  <Col span={24}>
                    <h1>Bells & Whistles Widget</h1>
                    <div>Graph</div>
                    <div>Map</div>
                    <div>External Links to buy</div>
                    <div>
                      External Links to Wikipedia other sources of information
                    </div>
                  </Col>
                </Row>
              </Col>
              <Col flex={2}>
                <Row>
                  <Col span={24}>
                    <h1>Common Hop Pairings</h1>
                    <div>Hop A</div>
                    <div>...</div>
                    <div>Hop Z</div>
                  </Col>
                </Row>
                <Row style={{ paddingTop: "16px" }}>
                  <Col span={24}>
                    <h1>Beer List</h1>
                    <div>Beer A</div>
                    <div> Paginate?...</div>
                    <div>Beer Z</div>
                  </Col>
                </Row>
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
