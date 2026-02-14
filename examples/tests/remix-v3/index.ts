import * as Path from "node:path";
import router from "./app/router";

let port = process.env.PORT ? parseInt(process.env.PORT, 10) : 44100;

const server = Bun.serve({
  port,
  routes: {
    "/dist/*": async (request) => {
      let url = new URL(request.url);

      let filepath = Path.join(
        import.meta.dirname,
        url.pathname.replace("/dist", "/app/client"),
      );

      let {
        outputs: [output],
      } = await Bun.build({
        entrypoints: [filepath],
        target: "browser",
        minify: Bun.env.NODE_ENV === "production",
        splitting: false,
        format: "esm",
        sourcemap: Bun.env.NODE_ENV === "production" ? "none" : "inline",
        jsx: { importSource: "@remix-run/dom" },
        external: ["@remix-run/*"],
        naming: {
          entry: "[dir]/[name].[ext]",
          chunk: "chunks/[hash].[ext]",
          asset: "assets/[name]-[hash].[ext]",
        },
      });

      return new Response(output);
    },
  },

  async fetch(request) {
    try {
      return await router.fetch(request);
    } catch (error) {
      console.error(error);
      return new Response("Internal Server Error", { status: 500 });
    }
  },
});

console.log("App is running on http://%s:%d", server.hostname, server.port);
