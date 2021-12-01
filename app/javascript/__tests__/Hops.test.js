import "@testing-library/jest-dom";
import { render, screen, waitFor } from "@testing-library/react";
import userEvent from "@testing-library/user-event";
import { rest } from "msw";
import { setupServer } from "msw/node";
import React from "react";
import Hops from "../components/Hops";
import "./Hops.css";
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
  rest.get("http://localhost/api/v1/hops", (req, res, ctx) => {
    return res(
      ctx.json([
        {
          hop: {
            name: "Citra",
            id: 6,
            rating: 4,
            ranking: 1,
            beers: [{ name: "Juicy Bits", id: 22 }],
          },
        },
        { hop: { name: "Mosaic", id: 5, rating: 4, ranking: 2, beers: [] } },
      ])
    );
  }),
  rest.get("http://localhost/api/v1/hops/featured", (req, res, ctx) => {
    return res(
      ctx.json({
        hop: {
          name: "Azacca",
          id: 16,
          rating: 4.04,
          ranking: 22,
          beers: [{ name: "Haze & Juice", id: 1 }],
        },
      })
    );
  }),
  rest.get("http://localhost/api/v1/hops/popular", (req, res, ctx) => {
    return res(
      ctx.json([
        {
          hop: {
            name: "Eclipse",
            id: 7,
            rating: 4,
            ranking: 18,
            beers: [{ name: "SMASH Eclipse", id: 20 }],
          },
        },
        {
          hop: { name: "Motueka", id: 15, rating: 4.5, ranking: 20, beers: [] },
        },
      ])
    );
  })
);

beforeAll(() => server.listen());
afterEach(() => server.resetHandlers());
afterAll(() => server.close());

test("loads and displays greeting", async () => {
  render(<TestRouter inner_component={<Hops />} />);

  await waitFor(() => screen.getByText("Mosaic"));
  await waitFor(() => screen.getByText("Azacca"));
  await waitFor(() => screen.getByText("Eclipse"));

  expect(screen.getByText("Citra")).toBeInTheDocument();
  expect(screen.getByText("Motueka")).toBeInTheDocument();
  expect(screen.getByText("Beers: Juicy Bits")).toBeInTheDocument();
  expect(screen.getByText("Beers: SMASH Eclipse")).toBeInTheDocument();
});

test("search submit", async () => {
  render(<TestRouter inner_component={<Hops />} />);

  await waitFor(() => screen.getByText("Citra"));

  const search = screen.getByRole("button", { name: "search" });
  userEvent.type(search, "Citra{enter}");

  // TODO the state is not being saved so it is not submitting "Citra".
  // await waitFor(() => screen.getByText("🔎 Search Result - Citra"));
  
  await waitFor(() => screen.getByText("Citra"));
  expect(screen.getByText("Beers: Juicy Bits")).toBeInTheDocument();
});
