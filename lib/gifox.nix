{
  stdenv,
  fetchurl,
  _7zz,
}:
stdenv.mkDerivation (finalAttrs: {
  name = "gifox";
  version = "020702.00";

  src = fetchurl {
    url = "https://d1fqctmfkpkkcg.cloudfront.net/gifox/${finalAttrs.version}.dmg";
    hash = "sha256-Roo0T1WFlBkU0aBIyrlrArbK+YRnFvDAuCV0Q1em34s=";
  };

  unpackPhase = ''
    runHook preUnpack
    7zz -snld x $src
    runHook postUnpack
  '';

  sourceRoot = ".";

  nativeBuildInputs = [_7zz];

  postInstall = ''
    mkdir -p $out/Applications
    mv Gifox/Gifox.app $out/Applications/
  '';
})
