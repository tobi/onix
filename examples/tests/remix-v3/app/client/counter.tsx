import { hydrated, type Remix } from "@remix-run/dom";
import { press } from "@remix-run/events/press";
import { signal } from "alien-signals";

type Props = { initial?: number };

export const Counter = hydrated<Props>(
  "/dist/counter.js#Counter",
  function Counter({ initial }) {
    return () => (
      <>
        {/* <PlainCounter initial={initial} /> */}
        {/* <StateCounter initial={initial} /> */}
        {/* <SignalCounter initial={initial} /> */}
        <StateClassCounter initial={initial} />
      </>
    );
  },
);

function PlainCounter(this: Remix.Handle, { initial }: Props) {
  let count = initial ?? 0;
  return () => (
    <button
      type="button"
      on={[
        press(() => {
          count++;
          this.update();
        }),
      ]}
    >
      Plain Counter: <span>{count}</span>
    </button>
  );
}

function state<T>(handle: Remix.Handle, initial: T) {
  let value = initial;

  return [
    () => value,
    (newValueOrFn: T | ((current: T) => T), renderFn?: Remix.Task) => {
      if (typeof newValueOrFn === "function") {
        value = (newValueOrFn as (current: T) => T)(value);
      } else {
        value = newValueOrFn;
      }
      handle.update(renderFn);
    },
  ] as const;
}

function StateCounter(this: Remix.Handle, { initial }: Props) {
  let [count, setCount] = state(this, initial ?? 0);
  return () => (
    <button
      type="button"
      on={[
        press(() => {
          setCount((c) => c + 1);
        }),
      ]}
    >
      State Counter: <span>{count()}</span>
    </button>
  );
}

function SignalCounter(this: Remix.Handle, { initial }: Props) {
  let count = signal(initial ?? 0);
  return () => (
    <button
      type="button"
      on={[
        press(() => {
          count(count() + 1);
          this.update();
        }),
      ]}
    >
      Signal Counter: <span>{count()}</span>
    </button>
  );
}

class State<T> {
  #handle: Remix.Handle;
  #value: T;

  constructor(handle: Remix.Handle, initial: T) {
    this.#handle = handle;
    this.#value = initial;
  }
  get value() {
    return this.#value;
  }
  set value(newValueOrFn: T) {
    this.#value = newValueOrFn;
    this.#handle.update();
  }
}

function StateClassCounter(this: Remix.Handle, { initial }: Props) {
  let count = new State(this, initial ?? 0);

  let log = new Effect(() => {
    console.log("Count changed:", count.value);
    return () => {
      console.log("Cleanup after count changed:", count.value);
    };
  });

  return () => {
    return log.run(
      () => (
        <button type="button" on={[press(() => count.value++)]}>
          State Class Counter: <span>{count.value}</span>
        </button>
      ),
      [count.value],
    );
  };
}

class Effect<T extends readonly unknown[] = readonly unknown[]> {
  #prevDeps?: T;
  #cleanup?: () => void;
  #fn: () => void | (() => void);

  constructor(fn: () => void | (() => void)) {
    this.#fn = fn;
  }

  run<F extends () => JSX.Element>(renderFn: F, deps: T): F {
    // Check if dependencies have changed
    const depsChanged =
      deps.length === 0 ||
      !this.#prevDeps ||
      deps.length !== this.#prevDeps.length ||
      deps.some((dep, i) => dep !== this.#prevDeps![i]);

    if (depsChanged) {
      if (this.#cleanup) this.#cleanup();

      const cleanup = this.#fn();

      this.#cleanup = typeof cleanup === "function" ? cleanup : undefined;
      this.#prevDeps = [...deps] as unknown as T;
    }

    return renderFn();
  }
}
