{
  stdenv,
  fetchurl,
  _7zz,
}:
stdenv.mkDerivation (finalAttrs: {
  name = "obs";
  version = "31.1.2";

  src = fetchurl {
    url = "https://cdn-fastly.obsproject.com/downloads/OBS-Studio-${finalAttrs.version}-macOS-Apple.dmg";
    hash = "sha256-jxgULIWZ1OgLruWROwP4NXw+X9C3aDX1Tnbe35+FcYg=";
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
    mv 'OBS Studio ${finalAttrs.version} (Apple)/OBS.app' $out/Applications/
  '';
})
