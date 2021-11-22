import { Layout, Menu, Breadcrumb, Row, Col } from "antd";

const { Header, Content, Footer } = Layout;

import React, { Component } from "react";
import { Link } from "react-router-dom";
import axios from "axios";
import "./Hops.css";
import { green } from "@ant-design/colors";
import Search from "antd/lib/input/Search";
import Hop from "./Hop";

class Hops extends Component {
  constructor(props) {
    super(props);
    this.handleChange = this.handleChange.bind(this);
    this.handleSearch = this.handleSearch.bind(this);
    this.state = {
      hops: [],
      hopName: "",
    };
    this.searchType = props.searchType ? props.searchType : "Top Rated Hops";
  }

  handleChange(e) {
    this.setState({ hopName: e.target.value });
  }

  handleSearch() {
    this.setState({ hops: [] });
    this.loadHops(this.state.hopName);
    this.searchType = "Search Result - " + this.state.hopName;
  }

  loadHops = (q) => {
    const url = "api/v1/hops?query=" + q;
    axios
      .get(url)
      .then((response) => {
        const { data } = response;
        data.map((el) => {
          const newEl = {
            key: el.hop.id,
            id: el.hop.id,
            name: el.hop.name,
            rating: el.hop.rating,
            ranking: el.hop.ranking,
            beers: el.hop.beers,
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
    this.loadHops("");
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
            <Search
              value={this.state.hopName}
              onChange={this.handleChange}
              onSearch={this.handleSearch}
              style={{ width: 200, marginTop: "16px" }}
            />
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
                <h1>{this.searchType}</h1>
                <div>
                  {this.state.hops.map((hop) => {
                    return <Hop hop={hop} />;
                  })}
                </div>
              </Col>
              <Col flex={2}>
                <Row>
                  <Col span={24}>
                    <h1>Featured</h1>
                    <div>
                      <p>Nam eget vulputate mauris.</p>
                      <p>raesent dictum est quis neque</p>
                    </div>
                  </Col>
                </Row>
                <Row style={{ paddingTop: "16px" }}>
                  <Col span={24}>
                    <h1>Hot Hops</h1>
                    <div id="lipsum">
                      <p>Lorem ipsum dolor sit amet</p>
                      <p>Ut rhoncus, libero id facilisis</p>
                    </div>
                  </Col>
                </Row>
              </Col>
            </Row>
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
