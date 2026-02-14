import type { RouteHandlers } from "@remix-run/fetch-router";
import type routes from "../../config/routes.js";
import { render } from "../helpers/render.js";
import { Layout } from "../components/layout.js";
import { fetchTodosQuery, TodoList } from "../client/todo-list.js";
import { ModulePreload } from "../components/module-preload.js";

export default {
  use: [],
  handlers: {
    async index({ request }) {
      let todos = await fetchTodosQuery.queryFn({ signal: request.signal });
      return render(
        <Layout>
          <h1>Todos</h1>
          <TodoList todos={todos} />
          <ModulePreload url={TodoList.$moduleUrl} />
        </Layout>,
      );
    },
  },
} satisfies RouteHandlers<typeof routes.todos>;
