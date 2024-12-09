let
  nixpkgs = fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixos-24.05";
  pkgs = import nixpkgs { config = {}; overlays = []; };
  sbcl' = pkgs.sbcl.withPackages (ps: with ps; [ hunchentoot trivia trivia_dot_ppcre ]);
in
  pkgs.mkShellNoCC {
    packages = [ sbcl' ];
}
