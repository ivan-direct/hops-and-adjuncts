import "@testing-library/jest-dom";
import { render, screen } from "@testing-library/react";
import React from "react";
import ErrorCard from "../components/ErrorCard";

window.matchMedia =
  window.matchMedia ||
  function () {
    return {
      matches: false,
      addListener: function () {},
      removeListener: function () {},
    };
  };

test("loads and displays Beer Card Component", () => {
  render(<ErrorCard />);

  expect(screen.getByText("Error")).toBeInTheDocument();
});
