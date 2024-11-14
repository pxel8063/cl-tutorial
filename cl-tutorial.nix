{
  pkgs
}:
pkgs.sbcl.buildASDFSystem {
  pname = "cl-tutorial";
  version = "0.0.1";
  src = builtins.path { path = ./.; name = "cl-tutorial"; };
  lispLibs = [
    pkgs.sbclPackages.hunchentoot
    pkgs.sbclPackages.djula
  ];
}
