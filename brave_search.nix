{
  pkgs,
  fetchFromGitHub,
  myutils,
  ...
}:
let
  brave_search = pkgs.sbcl.buildASDFSystem rec {
    pname = "brave_search";
    version = "0.0.1";
    src = pkgs.fetchFromGitHub {
      owner = "mark-watson";
      repo = "brave_search";
      rev = "b938a1bf0eaacfb03b6c9f856e5ce3493c4764d3";
      hash = "sha256-QQta8J5BhH8LlabYvZNZSek8NxPLR/woik0fJyHjC64=";
    };
    lispLibs = [
      pkgs.sbclPackages.cl-json
      pkgs.sbclPackages.drakma
      myutils
    ];
  };
  sbcl' = pkgs.sbcl.withOverrides (self: super: {
    inherit brave_search;
  });
in sbcl'.pkgs.brave_search
