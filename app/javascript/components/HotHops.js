import React, { Component } from "react";
import ErrorCard from "./ErrorCard";
import HopCard from "./HopCard";
import { getRequest } from "./NetworkHelper";

class HotHops extends Component {
  constructor(props) {
    super(props);
    this.state = {
      hops: [],
    };
  }

  componentDidMount() {
    this.loadHops();
  }

  loadHops = () => {
    const url = "api/v1/hops/popular";
    getRequest(url).then((response) => {
      const { data } = response;
      if (data.error_message === undefined) {
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
      }
    });
  };

  render() {
    const { hops } = this.state;
    const hopsPresent = hops.length > 0;
    return (
      <div>
        {hopsPresent &&
          hops.map((hop) => <HopCard hop={hop} key={`hot-${hop.id}`} />)}
        {!hopsPresent && <ErrorCard />}
      </div>
    );
  }
}

export default HotHops;
