import React, { Component } from "react";
import { Card } from "antd";

class BeerCard extends Component {
  constructor(props) {
    super(props);
    this.beer = props.beer;
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
        <p>TODO breweries will go here.</p>
      </Card>
    );
  }
}

export default BeerCard;
