import "@testing-library/jest-dom";
import { render, screen, waitFor } from "@testing-library/react";
import { rest } from "msw";
import { setupServer } from "msw/node";
import React from "react";
import HotAdjuncts from "../components/HotAdjuncts";
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
  rest.get("http://localhost/api/v1/adjuncts/popular", (req, res, ctx) => {
    return res(
      ctx.json([
        {
          adjunct: {
            name: "Coffee",
            id: 6,
            rating: 4,
            ranking: 1,
            beers: [{ name: "Nightmare Fuel", id: 22, rating: 4, ranking: 2, style: 'ipa' }],
          },
        },
        { adjunct: { name: "Marshmallow", id: 5, rating: 4, ranking: 2, beers: [] } },
      ])
    );
  })
);

beforeAll(() => server.listen());
afterEach(() => server.resetHandlers());
afterAll(() => server.close());

test("loads and displays greeting", async () => {
  render(<TestRouter inner_component={<HotAdjuncts />} />);

  await waitFor(() => screen.getByText("Coffee"));
  expect(screen.getByText("Marshmallow")).toBeInTheDocument();
  expect(screen.getByText("Beers: Nightmare Fuel")).toBeInTheDocument();
});

test("handles server error", async () => {
  server.use(
    rest.get("http://localhost/api/v1/adjuncts/popular", (req, res, ctx) => {
      return res(
        ctx.json({ code: 500, error_message: "Something Went Wrong!" })
      );
    })
  );

  render(<TestRouter inner_component={<HotAdjuncts />} />);

  await waitFor(() => screen.getByText("Error"));
  expect(screen.getByText("Error")).toBeInTheDocument();
});
