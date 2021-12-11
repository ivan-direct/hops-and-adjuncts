import "@testing-library/jest-dom";
import { render, screen, waitFor } from "@testing-library/react";
import userEvent from "@testing-library/user-event";
import { rest } from "msw";
import { setupServer } from "msw/node";
import React from "react";
import Adjuncts from "../components/Adjuncts";
import "./Adjuncts.css";
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
  rest.get("http://localhost/api/v1/adjuncts", (req, res, ctx) => {
    return res(
      ctx.json([
        {
          adjunct: {
            name: "Coffee",
            id: 6,
            rating: 4,
            ranking: 1,
            beers: [{ name: "Season of the Witch", id: 22, rating: 5, ranking: 1, style: 'ipa' }],
          },
        },
        { adjunct: { name: "Almond", id: 5, rating: 4, ranking: 2, beers: [] } },
      ])
    );
  }),
  rest.get("http://localhost/api/v1/adjuncts/popular", (req, res, ctx) => {
    return res(
      ctx.json([
        {
          adjunct: {
            name: "Maple Syrup",
            id: 7,
            rating: 4,
            ranking: 18,
            beers: [{ name: "Big Bad Baptist", id: 20, rating: 3, ranking: 3, style: 'ipa' }],
          },
        },
        {
          adjunct: { name: "Cocoa", id: 15, rating: 4.5, ranking: 20, beers: [] },
        },
      ])
    );
  })
);

beforeAll(() => server.listen());
afterEach(() => server.resetHandlers());
afterAll(() => server.close());

test("loads and displays greeting", async () => {
  render(<TestRouter inner_component={<Adjuncts />} />);

  await waitFor(() => screen.getByText("Almond"));
  await waitFor(() => screen.getByText("Maple Syrup"));

  expect(screen.getByText("Coffee")).toBeInTheDocument();
  expect(screen.getByText("Almond")).toBeInTheDocument();
  expect(screen.getByText("Beers: Season of the Witch")).toBeInTheDocument();
  expect(screen.getByText("Beers: Big Bad Baptist")).toBeInTheDocument();
});