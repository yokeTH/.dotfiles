{
  stdenvNoCC,
  fetchzip,
  undmg,
  nix-update-script,
}:
stdenvNoCC.mkDerivation {
  name = "keyboardcleantool";

  src = fetchzip {
    url = "https://folivora.ai/releases/KeyboardCleanTool.zip";
    hash = "sha256-FFrrMwc8LoMbqWE0vKXb19TFsxUY0bQQ0U8h2gHP2uM=";
    stripRoot = false;
  };

  sourceRoot = ".";

  nativeBuildInputs = [];

  installPhase = ''
    runHook preInstall

    mkdir -p "$out/Applications"
    ls
    cp -r source "$out/Applications/KeyboardCleanTool.app"

    runHook postInstall
  '';

  passthru.updateScript = nix-update-script {};
}
