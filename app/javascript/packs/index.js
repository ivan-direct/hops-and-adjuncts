import React from "react";
import ReactDOM from "react-dom";
import Home from "../components/Home";
import { BrowserRouter as Router, Switch, Route } from "react-router-dom";

const Routing = () => {
  return (
    <Home/>
    // <Router>
    //   <Switch>
    //     <Route exact path="/" component={Home} />
    //   </Switch>
    // </Router>
  );
};

ReactDOM.render(
  <React.StrictMode>
    <Routing />
  </React.StrictMode>,
  document.getElementById("root")
);
