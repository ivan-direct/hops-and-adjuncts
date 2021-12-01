import { green, red } from "@ant-design/colors";
import { DownCircleFilled, UpCircleFilled } from "@ant-design/icons";
import { Breadcrumb, Col, Layout, List, Menu, Row } from "antd";
import React, { Component } from "react";
import { Link } from "react-router-dom";
import BeerCard from "./BeerCard";
import "./Hops.css";
import { getRequest } from "./NetworkHelper";

const { Header, Content, Footer } = Layout;

class Hop extends Component {
  constructor(props) {
    super(props);
    this.state = {
      hop: {
        key: null,
        id: null,
        name: null,
        rating: null,
        ranking: null,
        beers: [
          {
            id: null,
            name: null,
            style: null,
            checkins: null,
            brewery: { name: null, city: null, state: null },
          },
        ],
        common_pairings: [],
        delta: null,
      },
    };
    this.params = props.params;
    this.url = "/api/v1/hops/" + this.params.id;
    // TODO replace me!
    this.description =
      "American floral hop released in 1998. A cross between Saaz and Mount Hood in character but easier to grow.";
  }

  loadHop = () => {
    getRequest(this.url)
      .then((response) => {
        const { data } = response;
        // TODO how to handle error response for full page???
        const { hop } = data;
        const newEl = {
          key: hop.id,
          id: hop.id,
          name: hop.name,
          rating: hop.rating,
          ranking: hop.ranking,
          beers: hop.beers,
          common_pairings: hop.common_pairings,
          delta: hop.delta,
        };
        this.setState({ hop: newEl });
        document.title = newEl.name;
      })
      .catch(function (error) {
        console.log(error);
      });
  };

  ratingChange(delta) {
    if (delta > 0) {
      return (
        <div>
          Ranking Change: <UpCircleFilled style={{ color: green[4] }} /> {delta}
        </div>
      );
    } else if (delta < 0) {
      return (
        <div>
          Ranking Change: <DownCircleFilled style={{ color: red[4] }} /> {delta}
        </div>
      );
    } else {
      return <div>No Change</div>;
    }
  }

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
              <Col flex={3} style={{ width: "50%", marginRight: "16px" }}>
                <Row>
                  <Col span={24}>
                    <List
                      size="small"
                      style={{ width: "85%" }}
                      header={<h1>About</h1>}
                      bordered
                      dataSource={[
                        "Description: " + this.description,
                        "Rating: " + this.state.hop.rating,
                        "Ranking: " + this.state.hop.ranking,
                        this.ratingChange(this.state.hop.delta),
                      ]}
                      renderItem={(item) => <List.Item>{item}</List.Item>}
                    />
                  </Col>
                </Row>
                <Row style={{ padding: "24px 0px" }}>
                  <Col span={24}>
                    <List
                      size="small"
                      style={{ width: "85%" }}
                      header={<h1>Common Hop Pairings</h1>}
                      bordered
                      dataSource={this.state.hop.common_pairings}
                      renderItem={(item) => <List.Item>{item}</List.Item>}
                    />
                  </Col>
                </Row>
              </Col>
              <Col flex={2}>
                {/* <Row>
                  <Col span={24}>
                    <h1>Bells & Whistles Widget</h1>
                    <div>Graph</div>
                    <div>Map</div>
                    <div>External Links to buy</div>
                    <div>
                      External Links to Wikipedia other sources of information
                    </div>
                  </Col>
                </Row> */}
                <Row>
                  <Col span={24}>
                    <List
                      size="medium"
                      header={<h1>{this.state.hop.name} Beers</h1>}
                      bordered
                      dataSource={this.state.hop.beers}
                      renderItem={(item) => (
                        <List.Item>
                          <BeerCard beer={item} key={item.id} />
                        </List.Item>
                      )}
                    />
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
