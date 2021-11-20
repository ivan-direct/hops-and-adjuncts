import React, { Component } from "react";
import Hops from "../components/Hops";
import { BrowserRouter as Router, Routes, Route } from "react-router-dom";
import "antd/dist/antd.css";

class App extends Component {
  render() {
    return (
      <Router>
        <div>
          <Routes>
            <Route path='/' element={<Hops/>} />
            <Route path='/hops' element={<Hops/>} />
          </Routes>
        </div>
      </Router>
    );
  }
}

export default App;
