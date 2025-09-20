{
  stdenv,
  fetchurl,
  _7zz,
}:
stdenv.mkDerivation (finalAttrs: {
  name = "burpsuite";
  version = "2025.8.4";

  src = fetchurl {
    url = "https://portswigger-cdn.net/burp/releases/download?product=community&version=${finalAttrs.version}&type=MacOsArm64";
    hash = "sha256-UZt/u9cAwvFMz9CtwgwH3volkCvoN30VdCn289r8ecw=";
  };

  unpackPhase = ''
    runHook preUnpack
    7zz -snld x $src
    runHook postUnpack
  '';

  sourceRoot = ".";

  nativeBuildInputs = [_7zz];

  postInstall = ''
    mkdir -p $out/Applications
    ls BurpSuiteCommunity
    mv "BurpSuiteCommunity/Burp Suite Community Edition.app" $out/Applications/
  '';
})
