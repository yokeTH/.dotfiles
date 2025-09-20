{
  stdenv,
  fetchurl,
  _7zz,
  makeWrapper,
}:
stdenv.mkDerivation (finalAttrs: {
  name = "proxyman";
  version1 = "52200";
  version2 = "5.22.0";

  src = fetchurl {
    url = "https://download.proxyman.io/${finalAttrs.version1}/Proxyman_${finalAttrs.version2}.dmg";
    hash = "sha256-UJzM/rVhVjW5gGyJSq8ta6PcLfskhHdHqOgYOfteLyU=";
  };

  unpackPhase = ''
    runHook preUnpack
    7zz -snld x $src
    runHook postUnpack
  '';

  sourceRoot = ".";

  nativeBuildInputs = [_7zz makeWrapper];

  postInstall = ''
    mkdir -p $out/Applications
    mv Proxyman.app $out/Applications/
    makeWrapper $out/Applications/Proxyman.app/Contents/MacOS/proxyman-cli $out/bin/proxyman-cli
  '';
})
