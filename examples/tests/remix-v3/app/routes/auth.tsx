import type { InferRouteHandler } from "@remix-run/fetch-router";
import type routes from "../../config/routes.js";
import { render } from "../helpers/render.js";
import authenticate from "../modules/auth.js";

export default {
  use: [],
  async handler({ request }) {
    try {
      let token = await authenticate(request);
      return render(<h1>Authenticated with token: {token}</h1>);
    } catch (error) {
      if (error instanceof Response) return error; // Handle thrown redirects
      console.error(new Error("Authentication failed", { cause: error }));
      return render(<h1>Authentication failed</h1>, { status: 401 });
    }
  },
} satisfies InferRouteHandler<typeof routes.auth>;
