{ pkgs, inputs }: let 
  chrome-devtools-src = inputs.chrome-devtools;
in pkgs.buildNpmPackage (final: {
  pname = "chrome-devtools-mcp";
  version = "chrome-devtools-mcp-v0.10.2";
  src = chrome-devtools-src;
  npmDepsHash = "sha256-Z95RGUjkzreYGjW/ZCHK2pibpMpzD3YDK7Xx3OuaB3k=";
  npmBuildScript = "bundle";
  PUPPETEER_SKIP_DOWNLOAD = "1";
})
