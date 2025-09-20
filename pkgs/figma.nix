{
  stdenvNoCC,
  fetchzip,
}:
stdenvNoCC.mkDerivation (finalAttrs: {
  name = "figma";
  version = "125.8.8";

  src = fetchzip {
    url = "https://desktop.figma.com/mac-arm/Figma-${finalAttrs.version}.zip";
    hash = "sha256-2CwKxJ8ibC4H86ElUme4M1niV0D27e5euYqG13zWoYc=";
    stripRoot = false;
  };

  sourceRoot = ".";

  installPhase = ''
    runHook preInstall

    mkdir -p "$out/Applications"
    ls
    mv "source/Figma.app" "$out/Applications/"

    runHook postInstall
  '';
})
