import React, { Component } from "react";
import Hops from "../components/Hops";
import Hop from "../components/Hop";
import { BrowserRouter as Router, Routes, Route, useParams } from "react-router-dom";
import "antd/dist/antd.css";

class App extends Component {
  render() {
    return (
      <Router>
        <Routes>
          <Route path="/" element={<Hops />} />
          <Route path="/hops" element={<Hops />} />
          <Route path="/hops/:id" element={<Hop />} />
        </Routes>
      </Router>
    );
  }
}

export default App;
