{ pkgs, inputs }: let 
  chrome-devtools-src = inputs.chrome-devtools;
in pkgs.buildNpmPackage (final: {
  pname = "chrome-devtools-mcp";
  version = "master";
  src = chrome-devtools-src;
  npmDepsHash = "sha256-uoGTEpcV/s1nEx6DytlH2WIvQlC1PdjVtpb20Q3EpSU=";
  npmBuildScript = "bundle";
  PUPPETEER_SKIP_DOWNLOAD = "1";
})
