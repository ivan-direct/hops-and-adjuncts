import { Card } from "antd";
import React, { Component } from "react";
import { Link } from "react-router-dom";
import PropTypes from "prop-types";

class HopCard extends Component {
  constructor(props) {
    super(props);
    this.hop = props.hop;
    this.hop_path = `/hops/${this.hop.id}`;
  }

  render() {
    const beerNames = this.hop.beers.map((beer) => beer.name).join(", ");
    return (
      <Card
        key={this.hop.id}
        title={<Link to={this.hop_path}>{this.hop.name}</Link>}
        bordered
        style={{ width: "65%", marginBottom: "16px" }}
      >
        <p>{`Rating: ${this.hop.rating}`}</p>
        <p>{`Ranking: ${this.hop.ranking}`}</p>
        <p>{this.hop.beers && `Beers: ${beerNames}`}</p>
      </Card>
    );
  }
}

HopCard.propTypes = {
  hop: PropTypes.shape({
    id: PropTypes.number.isRequired,
    name: PropTypes.string.isRequired,
    rating: PropTypes.number.isRequired,
    ranking: PropTypes.number.isRequired,
    beers: PropTypes.arrayOf(
      PropTypes.shape({
        name: PropTypes.string.isRequired,
      }),
    ),
  }).isRequired,
};

export default HopCard;
