{
  mkDerivation,
  pkgs,
  src,
  getExe,
  nodejs,
}:
let
  deps = mkDerivation {
    pname = "context7-deps";
    version = "master";
    src = "${src}";
    nativeBuildInputs = with pkgs; [ bun ];

    dontFixup = true;
    buildPhase = ''
      bun install --frozen-lockfile --no-cache
    '';
    installPhase = ''
      mkdir -p $out
      cp -r node_modules $out/
    '';

    outputHashAlgo = "sha256";
    outputHashMode = "recursive";
    outputHash = "sha256-Llp8aNfUpFFpSbfmlxCsrUqUSWkW1dORrfe2THhkK8I=";
  };
in
mkDerivation {
  pname = "context7";
  version = "master";
  src = "${src}";
  nativeBuildInputs = with pkgs; [ bun ];
  buildPhase = ''
    cp -r ${deps}/node_modules ./node_modules
    substituteInPlace node_modules/.bin/tsc \
      --replace-fail "/usr/bin/env node" "${getExe nodejs}"
    bun run build
    bun build dist/index.js --minify --compile --outfile=context7-mcp
  '';
  installPhase = ''
    mkdir -p $out/bin
    cp context7-mcp $out/bin/context7-mcp
  '';
}
