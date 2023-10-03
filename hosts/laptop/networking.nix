{ config, ... }:
{
  sops.secrets = {
    sub1 = { };
    sub2 = { };
  };

  sops.templates."config.dae".content = ''
    global {
      lan_interface: vnet0
      wan_interface: auto
      log_level: warning
      allow_insecure: false
      auto_config_kernel_parameter: true
    }

    subscription {
      '${config.sops.placeholder."sub1"}'
      '${config.sops.placeholder."sub2"}'
    }
    
    dns {
      fixed_domain_ttl {
        dns.alidns.com: 3600
          dns.google: 3600
          one.one.one.one: 3600
      }
      upstream {
        localdns: 'tcp://dns.alidns.com:53'
        overseadns: 'tcp://dns.google:53'
      }
      routing {
        request {
          fallback: localdns
        }
        response {
          qtype(aaaa) && upstream(overseadns) -> reject
            upstream(overseadns) -> accept
            upstream(localdns) && !ip(geoip:cn) -> overseadns
            ip(geoip:private) && !qname(geosite:cn) -> overseadns
            fallback: accept
        }
      }
    }
    
    group {
      proxy {
        #filter: name(keyword: HK, keyword: SG)
        policy: min_moving_avg
      }
    }
    
    routing {
      dport(22) -> direct
      domain(full: dns.google.com) -> proxy
      domain(full: one.one.one.one) -> proxy
      domain(full: dns.alidns.com) -> direct
    
      l4proto(tcp) && dport(5223) -> direct
      pname(NetworkManager, systemd-resolved, dnsmasq) && l4proto(udp) && dport(53) -> must_direct
      pname(zerotier-one, miniupnpd, airupnp, odhcpd, odhcp6c) -> must_direct
    
      dip(geoip:private) -> direct
      dip(geoip:cn) -> direct
      fallback: proxy
    }
  '';

  networking = {
    useDHCP = false;
    firewall.enable = false;
    networkmanager.enable = true;
  };
  services.dae = {
    enable = true;
    disableTxChecksumIpGeneric = false;
    configFile = config.sops.templates."config.dae".path;
  };
}

