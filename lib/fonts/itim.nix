{
  lib,
  stdenv,
  fetchFromGitHub,
}:
stdenv.mkDerivation {
  name = "itim";

  src = fetchFromGitHub {
    owner = "cadsondemak";
    repo = "itim";
    rev = "2e58604603cfe83feea58ae9ecc8f2bb91d4b0fa";
    sha256 = "sha256-LhL/j59dYWaqWAl/B4enFGcRX5Zt+detKhhPfkjUeQg=";
  };

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/fonts/{opentype,truetype}

    find $src/fonts -name '*.otf' -exec cp {} $out/share/fonts/opentype/ \;
    find $src/fonts -name '*.ttf' -exec cp {} $out/share/fonts/truetype/ \;

    runHook postInstall
  '';
}
