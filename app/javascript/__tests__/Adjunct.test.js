import "@testing-library/jest-dom";
import { render, screen, waitFor } from "@testing-library/react";
import { rest } from "msw";
import { setupServer } from "msw/node";
import React from "react";
import Adjunct from "../components/Adjunct";
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

describe("Negative Delta", () => {
  const server = setupServer(
    rest.get("http://localhost/api/v1/adjuncts/6", (req, res, ctx) => {
      return res(
        ctx.json({
          adjunct: {
            name: "Marshmallow",
            id: 6,
            rating: 4,
            ranking: 1,
            beers: [
              {
                name: "Mallow Noche",
                id: 22,
                checkins: 999,
                rating: 4,
                ranking: 2,
                style: 'ipa',
                brewery: { name: "WeldWerks", city: "Greeley", state: "CO" },
              },
            ],
            common_pairings: ["Cocoa", "Coconut"],
            delta: -2,
          },
        })
      );
    })
  );

  beforeAll(() => server.listen());
  afterEach(() => server.resetHandlers());
  afterAll(() => server.close());

  test("loads and displays greeting", async () => {
    render(<TestRouter inner_component={<Adjunct params={{ id: "6" }} />} />);

    await waitFor(() => screen.getByText("Marshmallow Beers"));
    expect(screen.getByText("Cocoa")).toBeInTheDocument();
    expect(screen.getByText("Coconut")).toBeInTheDocument();
    expect(screen.getByText("Ranking: 1")).toBeInTheDocument();
    expect(screen.getByText("Checkins: 999")).toBeInTheDocument();
    expect(screen.getByTestId("down-icon")).toBeInTheDocument();
  });
});

describe("Positive Delta", () => {
  const server = setupServer(
    rest.get("http://localhost/api/v1/adjuncts/6", (req, res, ctx) => {
      return res(
        ctx.json({
          adjunct: {
            name: "Marshmallow",
            id: 6,
            rating: 4,
            ranking: 1,
            beers: [
              {
                name: "Mallow Noche",
                id: 22,
                checkins: 999,
                rating: 4,
                ranking: 2,
                style: 'ipa',
                brewery: { name: "WeldWerks", city: "Greeley", state: "CO" },
              },
            ],
            common_pairings: ["Cocoa", "Coconut"],
            delta: 4,
          },
        })
      );
    })
  );

  beforeAll(() => server.listen());
  afterEach(() => server.resetHandlers());
  afterAll(() => server.close());

  test("loads and displays greeting", async () => {
    render(<TestRouter inner_component={<Adjunct params={{ id: "6" }} />} />);

    await waitFor(() => screen.getByText("Marshmallow Beers"));
    expect(screen.getByTestId("up-icon")).toBeInTheDocument();
  });
});
