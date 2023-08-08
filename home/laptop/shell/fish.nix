{ pkgs, ... }: {
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting
    '';
    functions = {
      __fish_command_not_found_handler = {
        body = "__fish_default_command_not_found_handler $argv[1]";
        onEvent = "fish_command_not_found";
      };
      gitignore = "curl -sL https://www.gitignore.io/api/$argv";
      fish_title = ''
        echo $argv[1] ' '
        echo (prompt_pwd)
        echo " fish"
      '';
    };

    shellAbbrs = {
      gc1 = "git clone --depth=1 ";
    };
    plugins = [
      {
        name = "hypro";
        src = pkgs.fetchFromGitHub {
          owner = "jorgebucaran";
          repo = "hydro";
          rev = "41b46a05c84a15fe391b9d43ecb71c7a243b5703";
          hash = "sha256-zmEa/GJ9jtjzeyJUWVNSz/wYrU2FtqhcHdgxzi6ANHg=";
        };
      }
      {
        name = "auto-venv";
        src = pkgs.fetchFromGitHub {
          owner = "nakulj";
          repo = "auto-venv";
          rev = "ec9ff89d9887e87fbf4ce22812163770b102295a";
          hash = "sha256-x9HzTBhpmoH/UeAOMj0f8LYTrQuhNElWa2gBEjol/h8=";
        };
      }
    ];
  };
}
