import { green } from "@ant-design/colors";
import { Layout, Menu } from "antd";
import React, { PureComponent } from "react";
import { Link } from "react-router-dom";
import adjunctImage from "../images/coconut.png";
import hopsImage from "../images/hops.png";

const { Header } = Layout;

class MainHeader extends PureComponent {
  render() {
    return (
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
        </Menu>
      </Header>
    );
  }
}

export default MainHeader;
