{
  stdenv,
  fetchurl,
  _7zz,
}:
stdenv.mkDerivation (finalAttrs: {
  name = "ungoogled-chromium";
  version = "140.0.7339.132-1.1";

  src = fetchurl {
    url = "https://github.com/ungoogled-software/ungoogled-chromium-macos/releases/download/${finalAttrs.version}/ungoogled-chromium_${finalAttrs.version}_arm64-macos.dmg";
    hash = "sha256-nuw+HMpOLpYZHEZMf5A54tAVCjpF0vkk4fBSbIlCkeI=";
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
    mv Chromium/Chromium.app $out/Applications/
  '';
})
