import React, { Component } from "react";
import { BrowserRouter as Router } from "react-router-dom";

class TestRouter extends Component {
  constructor(props) {
    super(props);
    this.inner_component = props.inner_component;
  }

  render() {
    return (
      <Router>
        <div>{this.inner_component}</div>
      </Router>
    );
  }
}

export default TestRouter;
