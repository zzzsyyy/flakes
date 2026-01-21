{ pkgs, ... }:
{
  nix = {
    channel.enable = false;
    package = pkgs.lixPackageSets.latest.lix; # nixVersions.latest;
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
        "auto-allocate-uids"
        "cgroups"
        "pipe-operator"
      ];
      auto-optimise-store = true;
      use-xdg-base-directories = true;
      auto-allocate-uids = true;
      use-cgroups = true;
      # max-jobs = 1;
      # cores = 2;
      substituters = [
        "https://attic.xuyh0120.win/lantian"
        "https://cache.garnix.io"
        # "https://mirror.sjtu.edu.cn/nix-channels/store"
        "https://mirrors.ustc.edu.cn/nix-channels/store"
      ];
      trusted-public-keys = [
        "lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc="
        "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
      ];
    };
    gc = {
      automatic = true;
      options = "--delete-older-than 3d";
      dates = "Sun 14:00";
    };
  };
}
