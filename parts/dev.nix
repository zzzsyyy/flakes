{
  perSystem =
    { config
    , inputs'
    , pkgs
    , self'
    , ...
    }: {
      devShells.default = pkgs.mkShell {
        shellHook = ''
          ${config.pre-commit.installationScript}
        '';
        packages = [
          self'.formatter
        ];
      };
      formatter = pkgs.nixpkgs-fmt;
      pre-commit.settings.hooks = {
        nixpkgs-fmt.enable = true;
        nil.enable = true;
      };
      devShells.secret = with pkgs; mkShell {
        nativeBuildInputs = [
          sops
          age
          ssh-to-age
          ssh-to-pgp
        ];
        shellHook = ''
          export PS1="\e[0;31m(Secret)\w\$ \e[m" 
        '';
      };
    };
}
