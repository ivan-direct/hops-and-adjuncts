import "@testing-library/jest-dom";
import { render, screen, waitFor } from "@testing-library/react";
import { rest } from "msw";
import { setupServer } from "msw/node";
import React from "react";
import HotHops from "../components/HotHops";
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
  rest.get("http://localhost/api/v1/hops/popular", (req, res, ctx) => {
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
  })
);

beforeAll(() => server.listen());
afterEach(() => server.resetHandlers());
afterAll(() => server.close());

test("loads and displays greeting", async () => {
  render(<TestRouter inner_component={<HotHops />} />);

  await waitFor(() => screen.getByText("Mosaic"));
  expect(screen.getByText("Citra")).toBeInTheDocument();
  expect(screen.getByText("Beers: Juicy Bits")).toBeInTheDocument();
});

test("handles server error", async () => {
  server.use(
    rest.get("http://localhost/api/v1/hops/popular", (req, res, ctx) => {
      return res(
        ctx.json({ code: 500, error_message: "Something Went Wrong!" })
      );
    })
  );

  render(<TestRouter inner_component={<HotHops />} />);

  await waitFor(() => screen.getByText("Error"));
  expect(screen.getByText("Error")).toBeInTheDocument();
});
