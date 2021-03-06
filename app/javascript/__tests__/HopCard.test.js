import "@testing-library/jest-dom";
import { render, screen } from "@testing-library/react";
import React from "react";
import HopCard from "../components/HopCard";
import TestRouter from "./TestRouter";

const hop = {
  name: "Azacca",
  id: 16,
  rating: 4.04,
  ranking: 22,
  beers: [{ name: "Haze & Juice", id: 1, rating: 4, ranking: 2, style: 'ipa' }],
};

test("loads and displays Hop Card Component", () => {
  render(<TestRouter inner_component={<HopCard hop={hop} key="1" />} />);

  expect(screen.getByText("Azacca")).toBeInTheDocument();
  expect(screen.getByText("Beers: Haze & Juice")).toBeInTheDocument();
});
