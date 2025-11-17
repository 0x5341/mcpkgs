{ pkgs, inputs }: let 
  chrome-devtools-src = inputs.chrome-devtools;
in pkgs.buildNpmPackage (final: {
  pname = "chrome-devtools-mcp";
  version = "chrome-devtools-mcp-v0.10.1";
  src = chrome-devtools-src;
  npmDepsHash = "sha256-T/R2h7WqR7L4jN8QjxB641MgjRr44DA3qlDgjD/c10k=";
  npmBuildScript = "bundle";
  PUPPETEER_SKIP_DOWNLOAD = "1";
})
