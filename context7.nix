{ pkgs, inputs, system }: 
inputs.bun2nix.lib.${system}.mkBunDerivation {
  pname = "context7-mcp";
  version = "master";
  src = inputs.context7;
  buildPhase = ''
    mkdir -p $out/bin
    bun run build
    bun build dist/index.js --compile --minify --sourcemap --bytecode --outfile context7-mcp
  '';
  dontStrip = true;
  bunNix = ./context7-bun.nix;
}
 