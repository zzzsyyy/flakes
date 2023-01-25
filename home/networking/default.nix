{ ... }:

{
    imports = [
        ./clash.nix
    ];

    networking = {
        hostName = "zzzsy";
        networkmanager.enable = true;
    };
}