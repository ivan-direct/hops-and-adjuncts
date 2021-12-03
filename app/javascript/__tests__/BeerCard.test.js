import "@testing-library/jest-dom";
import { render, screen } from "@testing-library/react";
import React from "react";
import BeerCard from "../components/BeerCard";
// import TestRouter from "./TestRouter";

const beer = {
  name: "Juicy Bits",
  id: 99,
  rating: 4.2,
  checkins: 53_700,
  style: "ipa",
  brewery: { name: "WeldWerks", city: "Greeley", state: "CO" },
};

test("loads and displays Beer Card Component", () => {
  // TODO needed when you implement the beer link //
  // render(<TestRouter inner_component={<BeerCard beer={beer} key="1" />} />);
  render(<BeerCard beer={beer} key="99" />);

  expect(screen.getByText("Juicy Bits")).toBeInTheDocument();
  expect(screen.getByText("Checkins: 53700")).toBeInTheDocument();
  expect(screen.getByText("Rating: 4.2")).toBeInTheDocument();
  expect(screen.getByText("Style: ipa")).toBeInTheDocument();
});
