{
  stdenvNoCC,
  fetchzip,
  nix-update-script,
}:
stdenvNoCC.mkDerivation (finalAttrs: {
  name = "imageoptim";
  version = "1.9.3";

  src = fetchzip {
    url = "https://imageoptim.com/ImageOptim${finalAttrs.version}.tar.xz";
    hash = "sha256-DTgGypH+lyc4T+WqSijEute5meNeZ8l2O1BPYm1rL+M=";
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
