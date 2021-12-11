import { Card } from "antd";
import React, { Component } from "react";
import { Link } from "react-router-dom";
import PropTypes from "prop-types";

class AdjunctCard extends Component {
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
    this.adjunct = props.adjunct;
    this.adjunct_path = `/adjuncts/${this.adjunct.id}`;
  }

  render() {
    const beerNames = AdjunctCard.truncatedString(this.adjunct.beers).map((beer) => beer.name).join(", ");
    const ellipsis = this.adjunct.beers.length > 10 ? "..." : "";
    return (
      <Card
        key={this.adjunct.id}
        title={<Link to={this.adjunct_path} className="hop-link">{this.adjunct.name}</Link>}
        bordered
        style={{ width: "65%", marginBottom: "16px" }}
      >
        <p>{`Rating: ${this.adjunct.rating}`}</p>
        <p>{`Ranking: ${this.adjunct.ranking}`}</p>
        <p style={{ maxWidth: "450px" }}>{this.adjunct.beers && `Beers: ${beerNames}${ellipsis}`}</p>
      </Card>
    );
  }
}

AdjunctCard.propTypes = {
  adjunct: PropTypes.shape({
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

export default AdjunctCard;
