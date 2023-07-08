{ lib
, pkgs
, config
, ...
}: {
  boot.extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback ];
  boot.extraModprobeConfig = ''
    options v4l2loopback exclusive_caps=1 video_nr=9 card_label="obs"
  '';
  boot.kernelModules = config.boot.kernelModules ++ [ "v4l2loopback" ];
}
