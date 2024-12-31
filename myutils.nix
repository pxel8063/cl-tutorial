{
  pkgs,
  fetchFromGitHub,
  ...
}:
let
  myutils = pkgs.sbcl.buildASDFSystem rec {
    pname = "myutils";
    version = "0.0.1";
    src = pkgs.fetchFromGitHub {
      owner = "mark-watson";
      repo = "myutils";
      rev = "a86e4d129722751886779e5f79db5b4dc327a836";
      hash = "sha256-oNl/Tki5E48BY45TVz3gF1J5mwsQ7ywz/M+Xu+ehwWI=";
    };
  };
  sbcl' = pkgs.sbcl.withOverrides (self: super: {
    inherit myutils;
  });
in sbcl'.pkgs.myutils
