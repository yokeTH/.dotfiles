{
  stdenvNoCC,
  fetchzip,
  nix-update-script,
}:
stdenvNoCC.mkDerivation (finalAttrs: {
  name = "macs-fan-control";
  version = "1.5.18";

  src = fetchzip {
    url = "https://github.com/crystalidea/macs-fan-control/releases/download/v${finalAttrs.version}/macsfancontrol.zip";
    hash = "sha256-TFOdNbZG+jjrdKRMu+0mn/UJPcUMRU6/5JDjqCzVXzs=";
    stripRoot = false;
  };

  sourceRoot = ".";

  installPhase = ''
    runHook preInstall

    mkdir -p "$out/Applications"
    ls
    mv "source/Macs Fan Control.app" "$out/Applications/Macs Fan Control.app"

    runHook postInstall
  '';

  passthru.updateScript = nix-update-script {};
})
