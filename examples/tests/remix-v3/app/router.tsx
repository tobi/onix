import { createRouter } from "@remix-run/fetch-router";
import { logger } from "@remix-run/fetch-router/logger-middleware";

import { render } from "./helpers/render.js";

import routes from "../config/routes.js";

import homeHandlers from "./routes/home.js";
import todosHandlers from "./routes/todos.js";
import authHandlers from "./routes/auth.js";

const router = createRouter({
  defaultHandler() {
    return render(<h1>404 Not Found</h1>);
  },
});

if (Bun.env.NODE_ENV === "development") router.use(logger());

router.map(routes.home, homeHandlers);
router.map(routes.todos, todosHandlers);
router.map(routes.auth, authHandlers);

export default router;
