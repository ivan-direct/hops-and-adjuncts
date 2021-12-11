import React, { Component } from "react";
import ErrorCard from "./ErrorCard";
import AdjunctCard from "./AdjunctCard";
import { getRequest } from "./NetworkHelper";

class HotAdjuncts extends Component {
  constructor(props) {
    super(props);
    this.state = {
      adjuncts: [],
    };
  }

  componentDidMount() {
    this.loadAdjuncts();
  }

  loadAdjuncts = () => {
    const url = "api/v1/adjuncts/popular";
    getRequest(url).then((response) => {
      const { data } = response;
      if (data.error_message === undefined) {
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
      }
    });
  };

  render() {
    const { adjuncts } = this.state;
    const adjunctsPresent = adjuncts.length > 0;
    return (
      <div>
        {adjunctsPresent &&
          adjuncts.map((adjunct) => <AdjunctCard adjunct={adjunct} key={`hot-${adjunct.id}`} />)}
        {!adjunctsPresent && <ErrorCard />}
      </div>
    );
  }
}

export default HotAdjuncts;
