{
  lib,
  stdenvNoCC,
  _7zz,
  fetchurl,
}:
stdenvNoCC.mkDerivation (finalAttrs: {
  name = "discord";
  version = "0.0.361";

  broken = true;

  src = fetchurl {
    url = "https://stable.dl2.discordapp.net/apps/osx/${finalAttrs.version}/Discord.dmg";
    hash = "sha256-B4kEHf3++Gs3sQ+WUPA5lmFRW0RCBmSHhppnofXabDY=";
  };

  sourceRoot = ".";

  unpackPhase = lib.optionalString stdenvNoCC.hostPlatform.isDarwin ''
    runHook preUnpack
    7zz -snld x $src
    runHook postUnpack
  '';

  nativeBuildInputs = [
    _7zz
  ];

  postInstall = ''
    mkdir -p $out/Applications
    mv Discord/Discord.app $out/Applications/
  '';
})
