import React, { Component } from "react";
import axios from "axios";
import { Card } from "antd";
import { Link } from "react-router-dom";

class FeaturedHop extends Component {
  constructor(props) {
    super(props);
    this.state = {
      hop: {
        id: null,
        name: null,
        rating: null,
        ranking: null,
        beers: [],
      },
    };
  }

  loadHops = () => {
    const url = "api/v1/hops/featured";
    axios
      .get(url)
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
    this.loadHops();
  }

  render() {
    return (
      <Card
        key={this.state.hop.id}
        title={
          <Link to={"/hops/" + this.state.hop.id}>{this.state.hop.name}</Link>
        }
        bordered={true}
        style={{ width: "65%", marginBottom: "16px" }}
      >
        <p>Rating: {this.state.hop.rating}</p>
        <p>Ranking: {this.state.hop.ranking}</p>
        <p>
          {this.state.hop.beers &&
            "Beers: " +
              this.state.hop.beers
                .map(function (beer) {
                  return beer.name;
                })
                .join(", ")}
        </p>
      </Card>
    );
  }
}

export default FeaturedHop;
