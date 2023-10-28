{ pkgs
, lib
, ...
}: {
  programs.helix.languages = {
    language = [
      {
        name = "bash";
        auto-format = true;
        formatter = {
          command = "${pkgs.shfmt}/bin/shfmt";
          args = [ "-i" "2" "-" ];
        };
      }
      {
        name = "nix";
        auto-format = true;
        formatter.command = "${pkgs.nixpkgs-fmt}/bin/nixpkgs-fmt";
      }
      {
        name = "c";
        auto-format = true;
        formatter = {
          command = "${pkgs.clang-tools}/bin/clang-format style=file";
          args = [ "-i" ];
        };
      }
    ];
    language-server = {
      clangd = {
        command = "${pkgs.clang-tools}/bin/clangd";
        clangd.fallbackFlags = [ "-std=c++2b" ];
      };
      nil = {
        command = lib.getExe pkgs.nil;
      };
    };
  };
}
