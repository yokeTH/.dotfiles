{
  stdenv,
  fetchFromGitHub,
  buildGoModule,
  lib,
}:
buildGoModule {
  pname = "deploys-cli";
  version = "1.1.0";

  src = fetchFromGitHub {
    owner = "yokeTH";
    repo = "contrib-deploys";
    rev = "e072a53a867fe986fd6033ea3d33d60465056c0f";
    sha256 = "sha256-7QeuvLXv5IgXE9fIyIesCkMHtkx/KRtXKvxdZJaDUms=";
  };

  vendorHash = "sha256-S5nq6DK4356LCMYKX3anjcySAxZhGxFWu1qKXR44C94=";

  meta = with lib; {
    description = "Deploys.app CLI";
    license = licenses.mit;
  };
}
