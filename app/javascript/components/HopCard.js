import React, { Component } from "react";
import { Link } from "react-router-dom";
import { Card } from "antd";

class HopCard extends Component {
  constructor(props) {
    super(props);
    this.hop = props.hop;
    this.hop_path = "/hops/" + this.hop.id;
  }

  render() {
    return (
      <Card
        key={this.hop.id}
        title={<Link to={this.hop_path}>{this.hop.name}</Link>}
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

export default HopCard;
