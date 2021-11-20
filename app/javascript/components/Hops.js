import { Layout } from "antd";
import React, { Component } from "react";

const { Content, Footer } = Layout;

class Hops extends Component {
  constructor(props) {
    super(props)
    this.state = {
      hops: []
    }
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
      <Layout className="layout">
        <Content style={{ padding: "0 50px" }}>
          <div className="site-layout-content" style={{ margin: "100px auto" }}>
            <h1>Hop Catalog</h1>
            <div>
              {this.state.hops.map((hop) => {
                return(
                  <div key={hop.id}>
                    <h1>{hop.name}</h1>
                  </div>
                )
              })}
            </div>
          </div>
        </Content>
        <Footer style={{ backgroundColor: 'Black', color: 'White', textAlign: "center" }}>Hi Nate!</Footer>
      </Layout>
    );
  }
}

export default Hops;
