{ ... }:

{
  imports = [
    ./clash.nix
  ];

  networking = {
    hostName = "zzzsy";
    networkmanager.enable = true;

    ## Configure network proxy
    # proxy.default = "http://user:password@proxy:port/";
    # proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  };
}
