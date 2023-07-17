{ pkgs
, ...
}:
{
  services.megasync = {
    enable = true;
    package = pkgs.symlinkJoin {
      name = "megasync";
      paths = [ pkgs.megasync ];
      buildInputs = [ pkgs.makeWrapper ];
      postBuild = ''
        wrapProgram $out/bin/megasync --prefix QT_SCALE_FACTOR : 1
      '';
    };
  };
}
