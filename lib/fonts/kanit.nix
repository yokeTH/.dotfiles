{
  stdenv,
  fetchFromGitHub,
}:
stdenv.mkDerivation {
  name = "kanit";

  src = fetchFromGitHub {
    owner = "cadsondemak";
    repo = "kanit";
    rev = "467dfe842185681d8042cd608b8291199dd37cda";
    sha256 = "0p0klb0376r8ki4ap2j99j7jcsq6wgb7m1hf3j1dkncwm7ikmg3h";
  };

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/fonts/{opentype,truetype}

    find $src/fonts -name '*.otf' -exec cp {} $out/share/fonts/opentype/ \;
    find $src/fonts -name '*.ttf' -exec cp {} $out/share/fonts/truetype/ \;

    runHook postInstall
  '';
}
