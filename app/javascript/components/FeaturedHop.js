import { Card } from "antd";
import React, { Component } from "react";
import { Link } from "react-router-dom";
import ErrorCard from "./ErrorCard";
import { getRequest } from "./NetworkHelper";

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
    getRequest(url).then((response) => {
      const { data } = response;
      if (data.error_message === undefined) {
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
      }
    });
  };

  componentDidMount() {
    this.loadHops();
  }

  render() {
    const hopPresent = this.state.hop.id != null;
    return (
      <>
        {hopPresent && (
          <Card
            key={this.state.hop.id}
            title={
              <Link to={"/hops/" + this.state.hop.id}>
                {this.state.hop.name}
              </Link>
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
        )}
        {!hopPresent && <ErrorCard />}
      </>
    );
  }
}

export default FeaturedHop;
