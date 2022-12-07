{
  description = "qTox development flake";

  outputs = { self, nixpkgs }:
    let inherit (nixpkgs) lib;
    in {
      overlay = import ./buildscripts/overlay.nix;

      legacyPackages =
        lib.mapAttrs (system: { extend, ... }: extend self.overlay)
        nixpkgs.legacyPackages;

      packages = lib.mapAttrs (system: pkgs: {
        default = pkgs.qtox;
        inherit (pkgs.extend self.overlay)
          libtoxcore toxext toxextMessages qtox;
      }) self.legacyPackages;
    };
}
