import { hydrated, type Remix } from "@remix-run/dom";
import { press } from "@remix-run/events/press";
import {
  QueryClient,
  QueriesObserver,
  type QueryObserverOptions,
} from "@tanstack/query-core";

type Todo = {
  userId: number;
  id: number;
  title: string;
  completed: boolean;
};

export const fetchTodosQuery = {
  queryKey: ["todos"],
  async queryFn({ signal }: { signal?: AbortSignal }) {
    await new Promise((resolve) => setTimeout(resolve, 1000));

    let response = await fetch("https://jsonplaceholder.typicode.com/todos", {
      signal,
    });

    return (await response.json()) as Todo[];
  },
};

export const TodoList = hydrated<{ todos: Todo[] }>(
  "/dist/todo-list.js#TodoList",
  function TodoList({ todos }) {
    let queryClient = new QueryClient();

    queryClient.setQueryData(["todos"], todos); // set initial data
    // subscribe to changes in the query and re-render when it changes
    observeQuery(this, queryClient, [fetchTodosQuery]);

    return () => {
      let state = queryClient.getQueryState<Todo[]>(["todos"]);
      let isFetching = state?.fetchStatus === "fetching";

      return (
        <div>
          <button
            disabled={isFetching}
            type="button"
            on={[press(() => queryClient.refetchQueries(fetchTodosQuery))]}
          >
            {isFetching ? "Loading…" : "Fetch Todos"}
          </button>

          <ul>
            {state?.data?.map((todo) => (
              <TodoItem key={todo.id} todo={todo} />
            ))}
          </ul>
        </div>
      );
    };
  },
);

function observeQuery(
  handle: Remix.Handle,
  queryClient: QueryClient,
  queries: Array<QueryObserverOptions<any, any, any, any, any>>,
) {
  let observer = new QueriesObserver(queryClient, queries);

  let unsubscribe = observer.subscribe(() => {
    // if for some reason this runs after the component is unmounted,
    // unsubscribe and return
    if (handle.signal.aborted) return unsubscribe();
    handle.update(); // trigger a re-render on every query change
  });

  // unsubscribe when component is removed
  handle.signal.addEventListener("abort", unsubscribe, { once: true });
}

function TodoItem({ todo }: { todo: Todo }) {
  return (
    <li>
      <label>
        <input type="checkbox" checked={todo.completed} />
        <span>{todo.title}</span>
      </label>
    </li>
  );
}
