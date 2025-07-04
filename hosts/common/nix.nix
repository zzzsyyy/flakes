{ pkgs, ... }:
{
  nix = {
    #channel.enable = false;
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
        "https://cache.ngi0.nixos.org"
        "https://nyx.chaotic.cx"
        "https://cache.garnix.io"
        # "https://mirror.sjtu.edu.cn/nix-channels/store"
        "https://mirrors.ustc.edu.cn/nix-channels/store"
      ];
      trusted-public-keys = [
        "cache.ngi0.nixos.org-1:KqH5CBLNSyX184S9BKZJo1LxrxJ9ltnY2uAs5c/f1MA="
        "nyx.chaotic.cx-1:HfnXSw4pj95iI/n17rIDy40agHj12WfF+Gqk6SonIT8="
        "chaotic-nyx.cachix.org-1:HfnXSw4pj95iI/n17rIDy40agHj12WfF+Gqk6SonIT8="
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
