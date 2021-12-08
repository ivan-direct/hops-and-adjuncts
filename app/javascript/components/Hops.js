import { green } from "@ant-design/colors";
import { Breadcrumb, Col, Layout, Menu, Row } from "antd";
import Search from "antd/lib/input/Search";
import PropTypes from "prop-types";
import React, { Component } from "react";
import { Link } from "react-router-dom";
import hopsImage from "../images/hops.png";
import FeaturedHop from "./FeaturedHop";
import HopCard from "./HopCard";
import HotHops from "./HotHops";
import MainFooter from "./MainFooter";
import { getRequest } from "./NetworkHelper";
import Spinner from "./Spinner";

const { Header, Content } = Layout;

class Hops extends Component {
  constructor(props) {
    super(props);
    this.handleChange = this.handleChange.bind(this);
    this.handleSearch = this.handleSearch.bind(this);
    this.state = {
      hops: [],
      hopName: "",
    };
    this.defaultHopListTitle = "🥇 Top Rated Hops";
    this.hopListTitle = props.hopListTitle
      ? props.hopListTitle
      : this.defaultHopListTitle;
  }

  componentDidMount() {
    this.loadHops("");
    document.title = "Hops";
  }

  handleChange(e) {
    this.setState({ hopName: e.target.value });
  }

  handleSearch() {
    this.setState({ hops: [] });
    // eslint-disable-next-line react/destructuring-assignment
    this.loadHops(this.state.hopName);
    // eslint-disable-next-line react/destructuring-assignment
    if (!this.state.hopName) {
      this.hopListTitle = this.defaultHopListTitle;
    } else {
      // eslint-disable-next-line react/destructuring-assignment
      this.hopListTitle = `🔎 Search Result - ${this.state.hopName}`;
    }
  }

  loadHops = (q) => {
    const url = `api/v1/hops?query=${q}`;
    getRequest(url).then((response) => {
      const { data } = response;
      data.forEach((el) => {
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
    });
  };

  render() {
    const { hopName } = this.state;
    const { hops } = this.state;
    const hopsPresent = hops.length > 0;

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
            <Search
              value={hopName}
              onChange={this.handleChange}
              onSearch={this.handleSearch}
              style={{ width: 200, marginTop: "16px" }}
            />
          </Menu>
        </Header>
        {!hopsPresent && <Spinner />}
        {hopsPresent && (
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
                  <h1>{this.hopListTitle}</h1>
                  <div>
                    {hops.map((hop) => (
                      <HopCard hop={hop} key={hop.id} />
                    ))}
                  </div>
                </Col>
                <Col flex={2}>
                  <Row>
                    <Col span={24}>
                      <h1>⭐ Featured</h1>
                      <FeaturedHop />
                    </Col>
                  </Row>
                  <Row style={{ paddingTop: "16px" }}>
                    <Col span={24}>
                      <h1>🔥 Hot Hops</h1>
                      <HotHops />
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

Hops.propTypes = {
  hopListTitle: PropTypes.string,
};

Hops.defaultProps = {
  hopListTitle: "🥇 Top Rated Hops",
};

export default Hops;
