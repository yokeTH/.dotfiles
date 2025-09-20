{
  stdenv,
  fetchurl,
  _7zz,
}:
stdenv.mkDerivation (finalAttrs: {
  name = "vlc";
  version = "3.0.21";

  src = fetchurl {
    url = "https://get.videolan.org/vlc/${finalAttrs.version}/macosx/vlc-${finalAttrs.version}-arm64.dmg";
    hash = "sha256-Fd1lv2SJ2p7Gpn9VhcdMQKWJk6z/QagpWKkW3XQXgEQ=";
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
    mv 'VLC media player/VLC.app' $out/Applications/
  '';
})
