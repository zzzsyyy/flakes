{
  programs.starship = {
    enable = false;
    settings = builtins.fromTOML (builtins.readFile ./starship.toml);
  };
}
