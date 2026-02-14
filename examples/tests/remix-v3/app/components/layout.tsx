import type { Remix } from "@remix-run/dom";

import { ModulePreload } from "./module-preload.js";

const importmap = {
  imports: {
    "@remix-run/dom":
      "https://unpkg.com/@remix-run/dom@0.0.0-experimental-remix-jam.6/dist/index.js",
    "@remix-run/events":
      "https://unpkg.com/@remix-run/events@0.0.0-experimental-remix-jam.5/dist/index.js",
    "@remix-run/events/press":
      "https://unpkg.com/@remix-run/events@0.0.0-experimental-remix-jam.5/dist/interactions/press.js",
    "@remix-run/style":
      "https://unpkg.com/@remix-run/style@0.0.0-experimental-remix-jam.1/dist/index.js",
    "@remix-run/dom/jsx-dev-runtime":
      "https://unpkg.com/@remix-run/dom@0.0.0-experimental-remix-jam.6/dist/jsx-dev-runtime.js",
    "alien-signals": "https://unpkg.com/alien-signals@3.0.0/esm/index.mjs",
    "@tanstack/query-core":
      "https://unpkg.com/@tanstack/query-core@5.90.2/build/legacy/index.js",
  },
};

export function Layout({ children }: { children: Remix.RemixNode }) {
  return (
    <html lang="en">
      <head>
        <meta charSet="utf-8" />
        <title>Remix UI - Demo with Bun</title>
        <link rel="preconnect" href="https://unpkg.com" />
        <script type="importmap" innerHTML={JSON.stringify(importmap)} />
        {Object.values(importmap.imports).map((value) => (
          <ModulePreload url={value} />
        ))}
        <ModulePreload url="/dist/style.js" />
      </head>
      <body>
        {children}
        <script type="module" src="/dist/entry.js" />
      </body>
    </html>
  );
}
