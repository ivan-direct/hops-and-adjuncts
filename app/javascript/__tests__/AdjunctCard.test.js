import "@testing-library/jest-dom";
import { render, screen } from "@testing-library/react";
import React from "react";
import AdjunctCard from "../components/AdjunctCard";
import TestRouter from "./TestRouter";

const adjunct = {
  name: "Marshmallow",
  id: 16,
  rating: 4.04,
  ranking: 22,
  beers: [{ name: "Mass Effect", id: 1, rating: 4, ranking: 2, style: 'stout' }],
};

test("loads and displays Adjunct Card Component", () => {
  render(<TestRouter inner_component={<AdjunctCard adjunct={adjunct} key="1" />} />);

  expect(screen.getByText("Marshmallow")).toBeInTheDocument();
  expect(screen.getByText("Beers: Mass Effect")).toBeInTheDocument();
});
