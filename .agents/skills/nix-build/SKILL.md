---
name: nix-build
description: Compatibility shim for Nix build triage. Route Ruby gem failures to `/nix-ruby-build` and Node/pnpm failures to `/nix-pnpm-build`.
---

# Nix Build Routing (Compatibility Shim)

This skill exists for backward compatibility only.

## Route Selection

| If you are fixing... | Use this skill |
|---|---|
| Ruby gem failures (`Gemfile.lock`, extconf, native gems, `onix build <project> <gem>`) | `/nix-ruby-build` |
| Node/pnpm failures (`pnpm-lock.yaml`, `onix build <project> node`, `onix hydrate`) | `/nix-pnpm-build` |

## Quick Decision Rules

1. If the error references `extconf.rb`, `mkmf`, Ruby gems, or `overlays/<gem>.nix`: use `/nix-ruby-build`.
2. If the error references `pnpm`, `node_modules`, `overlays/node/*.nix`, or hydration markers: use `/nix-pnpm-build`.
3. If both fail in one run, split work by pipeline and run both skills.

## Notes

- Do not hand-edit generated files in `nix/`; regenerate with `onix generate`.
- Keep overlay work in `overlays/` (Ruby) or `overlays/node/` (Node).
