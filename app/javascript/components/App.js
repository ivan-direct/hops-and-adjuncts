import "antd/dist/antd.css";
import "./Hops.css";
import React, { PureComponent } from "react";
import {
  BrowserRouter as Router,
  Route,
  Routes,
  useParams,
} from "react-router-dom";
import Hop from "./Hop";
import Hops from "./Hops";

const HopRouteWrapper = function hopWrapper() {
  const params = useParams();
  return <Hop params={params} />;
};

class App extends PureComponent {
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

export default App;
