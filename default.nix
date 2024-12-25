let
  nixpkgs = fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixos-24.05";
  pkgs = import nixpkgs { config = {}; overlays = []; };
  cl-tutorial = pkgs.callPackage ./cl-tutorial.nix {};
  sbcl' = pkgs.sbcl.withPackages (ps: with ps; [ hunchentoot djula ]);
in
{
  inherit cl-tutorial;
  shell = pkgs.mkShellNoCC {
    inputsFrom = [ cl-tutorial ];
    packages = [
      sbcl'
      pkgs.openssl
    ];
   shellHook = ''
     export LD_LIBRARY_PATH=${pkgs.lib.makeLibraryPath([
	 pkgs.openssl ])}
   '';
   JAVA_HOME = "/usr/local/Cellar/openjdk/23.0.1";
 };
}
