import "antd/dist/antd.css";
import React, { Component } from "react";
import {
  BrowserRouter as Router,
  Route,
  Routes,
  useParams,
} from "react-router-dom";
import Hop from "../components/Hop";
import Hops from "../components/Hops";

class App extends Component {
  render() {
    return (
      <Router>
        <Routes>
          <Route path="/" element={<Hops />} />
          <Route path="/hops" element={<Hops />} />
          <Route path="/hops/:id" element={<HopRouteWrapper />} />
        </Routes>
      </Router>
    );
  }
}

function HopRouteWrapper() {
  let params = useParams();
  return <Hop params={params} />;
}

export default App;
