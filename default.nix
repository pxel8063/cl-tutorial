let
  nixpkgs = fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixos-24.11";
  pkgs = import nixpkgs { config = {}; overlays = []; };
  myutils = pkgs.callPackage ./myutils.nix {};
  brave_search = pkgs.callPackage ./brave_search.nix { inherit myutils; };
  cl-tutorial = pkgs.callPackage ./cl-tutorial.nix {};
  sbcl' = pkgs.sbcl.withPackages (ps: with ps; [ hunchentoot djula cl-json ]);
in
{
  inherit brave_search;
  inherit cl-tutorial;
  inherit myutils;
  shell = pkgs.mkShellNoCC {
    inputsFrom = [ brave_search cl-tutorial myutils ];
    packages = [
      pkgs.zulu23
      sbcl'
      pkgs.openssl
    ];
   shellHook = ''
     export LD_LIBRARY_PATH=${pkgs.lib.makeLibraryPath([
	                          pkgs.openssl ])}
   '';
   JAVA_HOME = "${pkgs.zulu23}";
#   JAVA_HOME = "/usr/local/Cellar/openjdk/23.0.1";
 };
}
