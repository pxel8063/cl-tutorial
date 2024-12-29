let
  nixpkgs = fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixos-24.11";
  pkgs = import nixpkgs { config = {}; overlays = []; };
  cl-tutorial = pkgs.callPackage ./cl-tutorial.nix {};
  sbcl' = pkgs.sbcl.withPackages (ps: with ps; [ hunchentoot djula trivia]);
in
{
  inherit cl-tutorial;
  shell = pkgs.mkShellNoCC {
    inputsFrom = [ cl-tutorial ];
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
