{ config, pkgs, ... }:
{
  sops.secrets = {
    sub1 = { };
    sub2 = { };
  };

  sops.templates."config.dae".content = ''
    global {
      tcp_check_url: 'http://cp.cloudflare.com,1.1.1.1,2606:4700:4700::1111'
      udp_check_dns: 'dns.google.com:53,8.8.8.8,2001:4860:4860::8888'
      check_interval: 120s
      check_tolerance: 50ms
      dial_mode: domain
      lan_interface: vnet0
      wan_interface: auto
      log_level: warning
      allow_insecure: false
      auto_config_kernel_parameter: true
      tls_implementation: utls
      utls_imitate: chrome_auto
    }

    node {
      CL: 'socks5://127.0.0.1:7890'
    }

    subscription {
      # '${config.sops.placeholder."sub1"}'
      # '${config.sops.placeholder."sub2"}'
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
      # proxy {
      #   policy: min_moving_avg
      # }
      proxy {
        policy: fixed(0)
      }
    }
    
    routing {
      pname(clash, clash-meta, clash-verge) -> must_direct
      dport(22) -> direct
      domain(full: dns.google.com) -> proxy
      domain(full: one.one.one.one) -> proxy
      domain(full: dns.alidns.com) -> direct
    
      l4proto(tcp) && dport(5223) -> direct
      pname(NetworkManager, systemd-resolved) && l4proto(udp) && dport(53) -> must_direct
    
      dip(geoip:private) -> direct
      dip(geoip:cn) -> direct
      domain(geosite:cn) -> direct
      domain(geosite:category-ads) -> block

      fallback: proxy
    }
  '';

  networking = {
    useDHCP = false;
    firewall.enable = false;
    networkmanager.enable = true;
  };
  programs.clash-verge = {
    enable = true;
    autoStart = true;
    package = pkgs.my.clash-verge-rev;
  };
  services.dae = {
    enable = true;
    disableTxChecksumIpGeneric = false;
    configFile = config.sops.templates."config.dae".path;
  };
}
