{ pkgs
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
    ];
    language-server = {
      clangd = {
        command = "${pkgs.clang-tools}/bin/clangd";
        clangd.fallbackFlags = [ "-std=c++2b" ];
      };
      nil = {
        command = lib.getExe pkgs.nil;
        config.nil.formatting.command = [ "${lib.getExe pkgs.alejandra}" "-q" ];
      };
    };
  };
}
