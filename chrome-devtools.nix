{ pkgs, inputs }: let 
  chrome-devtools-src = inputs.chrome-devtools;
in pkgs.buildNpmPackage (final: {
  pname = "chrome-devtools-mcp";
  version = "chrome-devtools-mcp-v0.10.2";
  src = chrome-devtools-src;
  npmDepsHash = "sha256-mf43cdF4bH+BGmAtuI0PBRzqVOSbLaIJuQRIl10jSo8=";
  npmBuildScript = "bundle";
  PUPPETEER_SKIP_DOWNLOAD = "1";
})
