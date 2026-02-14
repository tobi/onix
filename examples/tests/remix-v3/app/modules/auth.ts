import { OAuth2Strategy } from "remix-auth-oauth2";

export default function authenticate(request: Request) {
  let url = new URL(request.url);

  let strategy = new OAuth2Strategy(
    {
      clientId: Bun.env.OAUTH_CLIENT_ID!,
      clientSecret: Bun.env.OAUTH_CLIENT_SECRET!,
      redirectURI: new URL("/auth", url),
      authorizationEndpoint: new URL("https://auth.sergiodxa.com/authorize"),
      tokenEndpoint: new URL("https://auth.sergiodxa.com/oauth/token"),
      scopes: ["openid", "profile", "email"],
    },
    async ({ tokens }) => tokens.accessToken(),
  );

  return strategy.authenticate(request);
}
