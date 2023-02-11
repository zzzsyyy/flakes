{ self, config, lib, ... }:

{
  config = {
    sops.gnupg.sshKeyPaths = [ ];
    sops.defaultSopsFile = ../secrets/common.yaml;
    sops.age.sshKeyPaths = [ "/home/zzzsy/.ssh/id_ed25519" ];
  };
}
