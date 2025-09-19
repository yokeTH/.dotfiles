{
  lib,
  stdenvNoCC,
  _7zz,
  fetchurl,
  makeBinaryWrapper,
}:
stdenvNoCC.mkDerivation (finalAttrs: {
  name = "git-fork";
  version = "2.57.1";

  broken = true;

  src = fetchurl {
    url = "https://cdn.fork.dev/mac/Fork-${finalAttrs.version}.dmg";
    hash = "sha256-hIrR655lCKBDkZS6cF7BD+WMvX13T9180rpAfUYc8YA=";
  };

  sourceRoot = ".";

  unpackPhase = lib.optionalString stdenvNoCC.hostPlatform.isDarwin ''
    runHook preUnpack
    7zz -snld x $src
    runHook postUnpack
  '';

  nativeBuildInputs = [
    _7zz
    makeBinaryWrapper
  ];

  postInstall = ''
    mkdir -p $out/Applications
    mv Fork/Fork.app $out/Applications/
    makeWrapper $out/Applications/Fork.app/Contents/Resources/fork_cli $out/bin/fork
  '';
})
