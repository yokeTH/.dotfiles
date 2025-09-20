{
  stdenv,
  fetchurl,
  _7zz,
}:
stdenv.mkDerivation (finalAttrs: {
  name = "clop";
  version = "2.10.4";

  src = fetchurl {
    url = "https://files.lowtechguys.com/releases/Clop-${finalAttrs.version}.dmg";
    hash = "sha256-FPvws42kao6P6OklWyouZh1wQdq24G7o7UmeRpPo39g=";
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
    mv Clop.app $out/Applications
  '';
})
