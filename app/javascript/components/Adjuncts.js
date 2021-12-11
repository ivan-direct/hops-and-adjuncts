import { green } from "@ant-design/colors";
import { Breadcrumb, Col, Layout, Menu, Row } from "antd";
import Search from "antd/lib/input/Search";
import PropTypes from "prop-types";
import React, { Component } from "react";
import { Link } from "react-router-dom";
import hopsImage from "../images/hops.png";
import adjunctImage from "../images/coconut.png";
import AdjunctCard from "./AdjunctCard";
import HotAdjuncts from "./HotAdjuncts";
import MainFooter from "./MainFooter";
import { getRequest } from "./NetworkHelper";
import Spinner from "./Spinner";

const { Header, Content } = Layout;

class Adjuncts extends Component {
  constructor(props) {
    super(props);
    this.handleChange = this.handleChange.bind(this);
    this.handleSearch = this.handleSearch.bind(this);
    this.state = {
      adjuncts: [],
      adjunctName: "",
      loadComplete: false,
    };
    this.defaultHopListTitle = "🥇 Top Rated Adjuncts";
    this.adjunctListTitle = props.adjunctListTitle
      ? props.adjunctListTitle
      : this.defaultHopListTitle;
  }

  componentDidMount() {
    this.loadHops("");
    document.title = "Adjuncts";
  }

  handleChange(e) {
    this.setState({ adjunctName: e.target.value });
  }

  handleSearch() {
    this.setState({ adjuncts: [] });
    // eslint-disable-next-line react/destructuring-assignment
    this.loadHops(this.state.adjunctName);
    // eslint-disable-next-line react/destructuring-assignment
    if (!this.state.adjunctName) {
      this.adjunctListTitle = this.defaultHopListTitle;
    } else {
      // eslint-disable-next-line react/destructuring-assignment
      this.adjunctListTitle = `🔎 Search Result - ${this.state.adjunctName}`;
      this.setState({ loadComplete: true });
    }
  }

  loadHops = (q) => {
    const url = `api/v1/adjuncts?query=${q}`;
    getRequest(url).then((response) => {
      const { data } = response;
      data.forEach((el) => {
        const newEl = {
          key: el.adjunct.id,
          id: el.adjunct.id,
          name: el.adjunct.name,
          rating: el.adjunct.rating,
          ranking: el.adjunct.ranking,
          beers: el.adjunct.beers,
        };
        this.setState((prevState) => ({
          adjuncts: [...prevState.adjuncts, newEl],
        }));
      });
      this.setState({ loadComplete: true });
    });
  };

  render() {
    const { adjunctName } = this.state;
    const { adjuncts } = this.state;
    const { loadComplete } = this.state;

    return (
      <Layout className="layout">
        <Header style={{ background: green[2] }}>
          <Menu theme="light" mode="horizontal">
            <Menu.Item key="0">
              <Link
                style={{
                  fontSize: "18px",
                  fontWeight: "bolder",
                  color: green[8],
                }}
                to="/"
              >
                <span>Hops </span>
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
            <Menu.Item key="1">
              <Link
                style={{
                  fontSize: "18px",
                  fontWeight: "bolder",
                  color: green[8],
                }}
                to="/adjuncts"
              >
                <span>Adjuncts </span>
                <img
                  src={adjunctImage}
                  alt="H/A Logo"
                  style={{
                    paddingBottom: "4px",
                    marginRight: "4px",
                    width: "31px",
                    height: "31px",
                  }}
                />
              </Link>
            </Menu.Item>
            <Menu.Item key="2" id="search-item">
              <Search
                value={adjunctName}
                onChange={this.handleChange}
                onSearch={this.handleSearch}
                style={{ width: 200, marginTop: "16px" }}
              />
            </Menu.Item>
          </Menu>
        </Header>
        {(!loadComplete && <Spinner />) || (
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
                  <h1>{this.adjunctListTitle}</h1>
                  <div>
                    {adjuncts.map((adjunct) => (
                      <AdjunctCard adjunct={adjunct} key={adjunct.id} />
                    ))}
                  </div>
                </Col>
                <Col flex={2}>
                  <Row style={{ paddingTop: "16px" }}>
                    <Col span={24}>
                      <h1>🔥 Hot Adjuncts</h1>
                      <HotAdjuncts />
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

Adjuncts.propTypes = {
  adjunctListTitle: PropTypes.string,
};

Adjuncts.defaultProps = {
  adjunctListTitle: "🥇 Top Rated Adjuncts",
};

export default Adjuncts;
