{
  stdenvNoCC,
  fetchzip,
  nix-update-script,
}:
stdenvNoCC.mkDerivation (finalAttrs: {
  name = "imageoptim";
  version = "1.5.18";

  src = fetchzip {
    url = "https://imageoptim.com/ImageOptim${finalAttrs.version}.tar.xz";
    hash = "sha256-TFOdNbZG+jjrdKRMu+0mn/UJPcUMRU6/5JDjqCzVXzs=";
    stripRoot = false;
  };

  sourceRoot = ".";

  installPhase = ''
    runHook preInstall

    mkdir -p "$out/Applications"
    ls source
    mv "source/ImageOptim.app" "$out/Applications/ImageOptim.app"

    runHook postInstall
  '';

  passthru.updateScript = nix-update-script {};
})
