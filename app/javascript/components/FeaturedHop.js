import { Card } from "antd";
import React, { Component } from "react";
import { Link } from "react-router-dom";
import ErrorCard from "./ErrorCard";
import { getRequest } from "./NetworkHelper";

class FeaturedHop extends Component {
  static truncatedString(beers) {
    const size = beers.length > 10 ? 10 : beers.length;
    const newArray = [];
    for (let index = 0; index < size; index += 1) {
      const element = beers[index];
      newArray.push(element);
    }
    return newArray;
  }

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

  componentDidMount() {
    this.loadHops();
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

  render() {
    const { hop } = this.state;
    const beerNames = FeaturedHop.truncatedString(hop.beers)
      .map((beer) => beer.name)
      .join(", ");
    const ellipsis = hop.beers.length > 10 ? "..." : "";
    const hopPresent = hop.id != null;
    return (
      <>
        {hopPresent && (
          <Card
            key={hop.id}
            title={<Link to={`/hops/${hop.id}`}>{hop.name}</Link>}
            bordered
            style={{ width: "65%", marginBottom: "16px" }}
          >
            <p>{`Rating: ${hop.rating}`}</p>
            <p>{`Ranking: ${hop.ranking}`}</p>
            <p style={{ maxWidth: "450px" }}>
              {hop.beers && `Beers: ${beerNames}${ellipsis}`}
            </p>
          </Card>
        )}
        {!hopPresent && <ErrorCard />}
      </>
    );
  }
}

export default FeaturedHop;
