import React, { Component } from "react";
import axios from "axios";
import HopCard from "./HopCard";

class HotHops extends Component {
  constructor(props) {
    super(props);
    this.state = {
      hops: [],
    };
  }

  loadHops = () => {
    const url = "api/v1/hops/popular";
    axios
      .get(url)
      .then((response) => {
        const { data } = response;
        data.map((el) => {
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
      })
      .catch(function (error) {
        // TODO Test coverage needed //
        console.log(error);
      });
  };

  componentDidMount() {
    this.loadHops();
  }

  render() {
    return (
      <div>
        {this.state.hops.map((hop) => {
          return <HopCard hop={hop} key={"hot-" + hop.id} />;
        })}
      </div>
    );
  }
}

export default HotHops;
