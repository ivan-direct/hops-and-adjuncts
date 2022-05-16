import { Card } from "antd";
import React, { Component } from "react";
import PropTypes from "prop-types";

class BeerCard extends Component {
  constructor(props) {
    super(props);
    this.beer = props.beer;
    this.brewery = props.beer.brewery;
  }

  render() {
    return (
      <Card
        key={this.beer.id}
        title={this.beer.name}
        bordered
        type="inner"
        style={{ width: "100%", margin: "8px" }}
      >
        <p>
          Brewery Rating:
          {` ${this.beer.rating}`}
        </p>
        <p>
          Checkins:
          {` ${this.beer.checkins}`}
        </p>
        <p>
          Style:
          {` ${this.beer.style}`}
        </p>
        <p>
          Brewery:
          {` ${this.brewery.name}`}
        </p>
        <p>
          Brewery Location:
          {` ${this.brewery.city}, ${this.brewery.state}`}
        </p>
      </Card>
    );
  }
}

BeerCard.propTypes = {
  beer: PropTypes.shape({
    id: PropTypes.number.isRequired,
    name: PropTypes.string.isRequired,
    rating: PropTypes.number.isRequired,
    checkins: PropTypes.number.isRequired,
    style: PropTypes.string.isRequired,
    brewery: PropTypes.shape({
      name: PropTypes.string.isRequired,
      city: PropTypes.string.isRequired,
      state: PropTypes.string.isRequired,
    }).isRequired,
  }).isRequired,
};

export default BeerCard;
