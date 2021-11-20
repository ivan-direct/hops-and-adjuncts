import React from "react";
import { rest } from "msw";
import { setupServer } from "msw/node";
import { render, waitFor, screen } from "@testing-library/react";
import "@testing-library/jest-dom";
import Hops from "../components/Hops";
import "./Hops.css";
import { BrowserRouter as Router } from "react-router-dom";

const server = setupServer(
  rest.get("http://localhost/api/v1/hops", (req, res, ctx) => {
    return res(
      ctx.json([
        { name: "Citra", id: 5 },
        { name: "Mosaic", id: 6 },
      ])
    );
  })
);

beforeAll(() => server.listen());
afterEach(() => server.resetHandlers());
afterAll(() => server.close());

test("loads and displays greeting", async () => {
  render(
    <Router>
      <div>
        <Hops />
      </div>
    </Router>
  );

  await waitFor(() => screen.getByText("Mosaic"));
  expect(screen.getByText("Citra")).toBeInTheDocument();
});
