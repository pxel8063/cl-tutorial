{
  pkgs,
  lib
}:
let
  fs = lib.fileset;
  sourceFiles =
    fs.difference
      (fs.gitTracked ./.)
      (fs.unions [
        (fs.maybeMissing ./result)
        (fs.maybeMissing ./result-2)
        ./.direnv
        ./.envrc
        ./.git
        ./.gitignore
        ./README.org
        ./brave_search.nix
        ./cl-tutorial.nix
        ./default.nix
        ./myutils.nix
        ./shell.nix
      ]);
in
pkgs.sbcl.buildASDFSystem {
  pname = "cl-tutorial";
  version = "0.0.1";
  src = fs.toSource {
    root = ./.;
    fileset = sourceFiles;
  };
  lispLibs = [
    pkgs.sbclPackages.djula
    pkgs.sbclPackages.hunchentoot
    pkgs.sbclPackages.trivia
  ];
}
