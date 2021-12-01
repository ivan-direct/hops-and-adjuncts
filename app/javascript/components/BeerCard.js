import { Card } from "antd";
import React, { Component } from "react";

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
        bordered={true}
        type="inner"
        style={{ width: "100%", margin: "8px" }}
      >
        <p>Rating: {this.beer.rating}</p>
        <p>Checkins: {this.beer.checkins}</p>
        <p>Style: {this.beer.style}</p>
        <p>Brewery: {this.brewery.name}</p>
        <p>
          Brewery Location: {this.brewery.city}, {this.brewery.state}
        </p>
      </Card>
    );
  }
}

export default BeerCard;
