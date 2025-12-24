{
  description = "Tinsel Tunes";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    godot-builder.url = "github:Samiser/godot-builder";
  };

  outputs = {
    nixpkgs,
    godot-builder,
    ...
  }: let
    systems = ["x86_64-linux" "aarch64-linux"];
    forAllSystems = nixpkgs.lib.genAttrs systems;

    games = forAllSystems (
      system:
        godot-builder.lib.buildGodotWebGame {
          pkgs = nixpkgs.legacyPackages.${system};
          pname = "tinsel-tunes";
          version = "1.0.0";
          src = ./.;
          exportPreset = "main";
          itchTarget = "samiser/tinsel-tunes";
        }
    );
  in {
    packages = forAllSystems (system: {
      default = games.${system}.package;
    });

    devShells = forAllSystems (system: {
      default = games.${system}.devShell;
    });
  };
}
