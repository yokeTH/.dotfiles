{
  lib,
  fetchurl,
  nodejs,
  makeWrapper,
  stdenv,
}:
let
  chalk = fetchurl {
    url = "https://registry.npmjs.org/chalk/-/chalk-5.4.1.tgz";
    hash = "sha256-hLi584anZ4H0SCJ5r0LRMbqFIxU4hkOZnhX5W0f/0No=";
  };
in
stdenv.mkDerivation {
  pname = "portless";
  version = "0.7.2";

  src = fetchurl {
    url = "https://registry.npmjs.org/portless/-/portless-0.7.2.tgz";
    hash = "sha256-zfPyhJT/WlFkZ+198p2j7Xl2Znxpj3VRR+6zZX0/dK4=";
  };

  nativeBuildInputs = [makeWrapper];

  unpackPhase = ''
    mkdir -p $out/lib/node_modules/portless
    tar xzf $src --strip-components=1 -C $out/lib/node_modules/portless
  '';

  installPhase = ''
    mkdir -p $out/lib/node_modules/portless/node_modules
    mkdir -p $out/lib/node_modules/portless/node_modules/chalk
    tar xzf ${chalk} --strip-components=1 -C $out/lib/node_modules/portless/node_modules/chalk

    mkdir -p $out/bin
    makeWrapper ${nodejs}/bin/node $out/bin/portless \
      --add-flags "$out/lib/node_modules/portless/dist/cli.js"
  '';

  meta = with lib; {
    description = "Local dev proxy: stable .localhost URLs instead of ephemeral port numbers";
    homepage = "https://github.com/vercel-labs/portless";
    license = licenses.asl20;
    mainProgram = "portless";
  };
}
