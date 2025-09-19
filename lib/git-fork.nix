{
  stdenvNoCC,
  fetchurl,
  undmg,
  nix-update-script,
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

  nativeBuildInputs = [undmg makeBinaryWrapper];

  installPhase = ''
    runHook preInstall

    mkdir -p "$out/Applications"
    mv Fork.app "$out/Applications"
    makeWrapper $out/Applications/Fork.app/Contents/Resources/fork_cli $out/bin/fork

    runHook postInstall
  '';

  passthru.updateScript = nix-update-script {};
})
