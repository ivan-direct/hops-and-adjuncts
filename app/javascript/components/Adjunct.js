import { green, red } from "@ant-design/colors";
import { DownCircleFilled, UpCircleFilled } from "@ant-design/icons";
import { Breadcrumb, Col, Layout, List, Menu, Row } from "antd";
import PropTypes from "prop-types";
import React, { Component } from "react";
import { Link } from "react-router-dom";
import hopsImage from "../images/hops.png";
import BeerCard from "./BeerCard";
import MainFooter from "./MainFooter";
import { getRequest } from "./NetworkHelper";

const { Header, Content } = Layout;

class Adjunct extends Component {
  constructor(props) {
    super(props);
    this.state = {
      adjunct: {
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
        description: null,
      },
    };
    this.params = props.params;
    this.url = `/api/v1/adjuncts/${this.params.id}`;
  }

  componentDidMount() {
    this.loadAdjunct();
  }

  loadAdjunct = () => {
    getRequest(this.url).then((response) => {
      const { data } = response;
      const { adjunct } = data;
      const newEl = {
        key: adjunct.id,
        id: adjunct.id,
        name: adjunct.name,
        rating: adjunct.rating,
        ranking: adjunct.ranking,
        beers: adjunct.beers,
        common_pairings: adjunct.common_pairings,
        delta: adjunct.delta,
      };
      this.setState({ adjunct: newEl });
      document.title = newEl.name;
    });
  };

  ratingChange(delta) {
    this.delta = delta;
    if (this.delta > 0) {
      return (
        <div>
          {"Ranking Change: "}
          <UpCircleFilled data-testid="up-icon" style={{ color: green[4] }} />
          {` ${this.delta}`}
        </div>
      );
    }
    if (this.delta < 0) {
      return (
        <div>
          {"Ranking Change: "}
          <DownCircleFilled data-testid="down-icon" style={{ color: red[4] }} />
          {` ${this.delta}`}
        </div>
      );
    }
    return <div>No Change</div>;
  }

  render() {
    const { adjunct } = this.state;
    const adjunctPresent = adjunct.id !== null;

    return (
      <Layout className="layout">
        <Header style={{ background: green[2] }}>
          <Menu theme="light" mode="horizontal">
            <Menu.Item key="0">
              <Link style={{ fontSize: "21px", fontWeight: "bolder" }} to="/">
                <img
                  src={hopsImage}
                  alt="H/A Logo"
                  style={{
                    paddingBottom: "4px",
                    width: "31px",
                    height: "31px",
                  }}
                />
              </Link>
            </Menu.Item>
          </Menu>
        </Header>
        {adjunctPresent && (
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
                          `Rating: ${adjunct.rating}`,
                          `Ranking: ${adjunct.ranking}`,
                          this.ratingChange(adjunct.delta),
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
                        header={<h1>Common Adjunct Pairings</h1>}
                        bordered
                        dataSource={adjunct.common_pairings}
                        renderItem={(item) => <List.Item>{item}</List.Item>}
                      />
                    </Col>
                  </Row>
                </Col>
                <Col flex={2}>
                  <Row>
                    <Col span={24}>
                      <List
                        size="medium"
                        header={
                          <h1>
                            {adjunct.name}
                            {" Beers"}
                          </h1>
                        }
                        bordered
                        dataSource={adjunct.beers}
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
        )}
        <MainFooter />
      </Layout>
    );
  }
}

Adjunct.propTypes = {
  params: PropTypes.shape({
    id: PropTypes.string.isRequired,
  }).isRequired,
};

export default Adjunct;
