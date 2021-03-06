import "@testing-library/jest-dom";
import { render, screen, waitFor } from "@testing-library/react";
import { rest } from "msw";
import { setupServer } from "msw/node";
import React from "react";
import FeaturedHop from "../components/FeaturedHop";
import TestRouter from "./TestRouter";

window.matchMedia =
  window.matchMedia ||
  function () {
    return {
      matches: false,
      addListener: function () {},
      removeListener: function () {},
    };
  };

const server = setupServer(
  rest.get("http://localhost/api/v1/hops/featured", (req, res, ctx) => {
    return res(
      ctx.json({
        hop: {
          name: "Azacca",
          id: 16,
          rating: 4.04,
          ranking: 22,
          beers: [{ name: "Haze & Juice", id: 1, rating: 4, ranking: 2, style: 'ipa' }],
        },
      })
    );
  })
);

beforeAll(() => server.listen());
afterEach(() => server.resetHandlers());
afterAll(() => server.close());

test("loads and displays greeting", async () => {
  render(<TestRouter inner_component={<FeaturedHop />} />);

  await waitFor(() => screen.getByText("Azacca"));
  expect(screen.getByText("Azacca")).toBeInTheDocument();
  expect(screen.getByText("Beers: Haze & Juice")).toBeInTheDocument();
});
