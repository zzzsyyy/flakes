{ pkgs
, ...
}: {
  nix = {
    #channel.enable = false;
    package = pkgs.nixUnstable;
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
      use-xdg-base-directories = true;
      # max-jobs = 1;
      # cores = 2;
      substituters = [
        "https://nyx.chaotic.cx"
        "https://cache.garnix.io"
        "https://mirrors.bfsu.edu.cn/nix-channels/store"
        "https://mirrors.ustc.edu.cn/nix-channels/store"
        "https://mirror.sjtu.edu.cn/nix-channels/store"
      ];
      trusted-public-keys = [
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
