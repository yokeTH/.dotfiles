{
  stdenvNoCC,
  fetchurl,
  undmg,
  nix-update-script,
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

  nativeBuildInputs = [undmg];

  installPhase = ''
    runHook preInstall

    mkdir -p "$out/Applications"
    mv Discord.app "$out/Applications"

    runHook postInstall
  '';

  passthru.updateScript = nix-update-script {};
})
