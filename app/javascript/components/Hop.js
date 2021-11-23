import React, { Component } from "react";
import { Card } from "antd";

class Hop extends Component {
  constructor(props) {
    super(props);
    this.hop = props.hop;
  }

  render() {
    return (
      <Card
        key={this.hop.id}
        title={this.hop.name}
        bordered={true}
        style={{ width: "65%", marginBottom: "16px" }}
      >
        <p>Rating: {this.hop.rating}</p>
        <p>Ranking: {this.hop.ranking}</p>
        <p>
          {this.hop.beers && "Beers: " +
            this.hop.beers
              .map(function (beer) {
                return beer.name;
              })
              .join(", ")}
        </p>
      </Card>
    );
  }
}

export default Hop;
