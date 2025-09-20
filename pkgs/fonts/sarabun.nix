{
  stdenv,
  fetchFromGitHub,
}:
stdenv.mkDerivation {
  name = "sarabun";

  src = fetchFromGitHub {
    owner = "cadsondemak";
    repo = "sarabun";
    rev = "854cdbc6afa002ff8c2ce6aa7b86f99c7f71c9eb";
    sha256 = "sha256-jcSQ72WK0GucZPgG7IQKrKzCOEbGgbQVl21RIKSF6A0=";
  };

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/fonts/{opentype,truetype}

    find $src/fonts -name '*.otf' -exec cp {} $out/share/fonts/opentype/ \;
    find $src/fonts -name '*.ttf' -exec cp {} $out/share/fonts/truetype/ \;

    runHook postInstall
  '';
}
