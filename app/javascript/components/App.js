import "antd/dist/antd.less";
import "./Hops.less";
import React, { PureComponent } from "react";
import {
  BrowserRouter as Router,
  Route,
  Routes,
  useParams,
} from "react-router-dom";
import Hop from "./Hop";
import Hops from "./Hops";
import Adjuncts from "./Adjuncts";
import Adjunct from "./Adjunct";

const HopRouteWrapper = function hopWrapper() {
  const params = useParams();
  return <Hop params={params} />;
};

const AdjunctRouteWrapper = function adjunctWrapper() {
  const params = useParams();
  return <Adjunct params={params} />;
};

class App extends PureComponent {
  render() {
    return (
      <Router>
        <Routes>
          <Route path="/" element={<Hops />} />
          <Route path="/hops" element={<Hops />} />
          <Route path="/hops/:id" element={<HopRouteWrapper />} />
          <Route path="/adjuncts" element={<Adjuncts />} />
          <Route path="/adjuncts/:id" element={<AdjunctRouteWrapper />} />
        </Routes>
      </Router>
    );
  }
}

export default App;
