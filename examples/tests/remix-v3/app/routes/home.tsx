import type { InferRouteHandler } from "@remix-run/fetch-router";

import type routes from "../../config/routes.js";
import { render } from "../helpers/render.js";
import { Counter } from "../client/counter.js";
import { Layout } from "../components/layout.js";
import { ModulePreload } from "../components/module-preload.js";

export default {
  use: [],
  handler() {
    return render(
      <Layout>
        <h1>Home</h1>
        <ModulePreload url={Counter.$moduleUrl} />
        <Counter initial={5} />
      </Layout>,
    );
  },
} satisfies InferRouteHandler<typeof routes.home>;
