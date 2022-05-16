import { Card } from "antd";
import React, { Component } from "react";
import { Link } from "react-router-dom";
import PropTypes from "prop-types";

class HopCard extends Component {
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
    this.hop = props.hop;
    this.hop_path = `/hops/${this.hop.id}`;
  }

  render() {
    const beerNames = HopCard.truncatedString(this.hop.beers).map((beer) => beer.name).join(", ");
    const ellipsis = this.hop.beers.length > 10 ? "..." : "";
    return (
      <Card
        key={this.hop.id}
        title={<Link to={this.hop_path} className="hop-link">{this.hop.name}</Link>}
        bordered
        style={{ width: "65%", marginBottom: "16px" }}
      >
        <p>{`Hop Rating: ${this.hop.rating}`}</p>
        <p>{`Hop Ranking: ${this.hop.ranking}`}</p>
        <p style={{ maxWidth: "450px" }}>{this.hop.beers && `Beers: ${beerNames}${ellipsis}`}</p>
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
