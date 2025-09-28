{
  fetchurl,
  _7zz,
  stdenv,
}:
stdenv.mkDerivation (finalAttrs: {
  name = "tableplus";
  version = "637";
  src = fetchurl {
    url = "https://files.tableplus.com/macos/${finalAttrs.version}/TablePlus.dmg";
    hash = "sha256-Coc4Y16SEyRAUxbU+6P6dE9cfdQESHHpFZYQPfQ1WOU=";
  };

  sourceRoot = "TablePlus.app";

  nativeBuildInputs = [_7zz];

  installPhase = ''
    runHook preInstall

    mkdir -p "$out/Applications/TablePlus.app"
    cp -R . "$out/Applications/TablePlus.app"
    mkdir "$out/bin"
    ln -s "$out/Applications/TablePlus.app/Contents/MacOS/TablePlus" "$out/bin/${finalAttrs.name}"

    runHook postInstall
  '';
})
