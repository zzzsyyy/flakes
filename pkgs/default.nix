{ config, lib, pkgs, ...}:

let

	build-tools = with pkgs; [
		cmake
		gcc gdb
		ncurses5
		git
    clang
    clang-tools
		lua
		rustc
                rustup
    		rust-analyzer
    		rnix-lsp
    		cargo
	];

	nixpkgs-tools = with pkgs; [
		nixpkgs-fmt
		nixpkgs-lint
		nixpkgs-review
		nixpkgs-pytools
		nix-index
		nix-du
		manix
	];

  office = with pkgs; [
    abiword
    libreoffice
  ];
	gui-tools = with pkgs; [
		tdesktop
		vlc
	];

	modern-unix = with pkgs; [
		exa
		bat
		ranger
	];
	zhumu = pkgs.callPackage (import ./zhumu) {};
in
{
	environment.systemPackages = 
		nixpkgs-tools
		++ gui-tools
    ++ office
		++ modern-unix
		++ build-tools
		++ (with pkgs; [
			dunst
			rofi
			autotiling
			rofi-emoji
			kitty
			cinnamon.nemo			
			neofetch
			man
			htop
			rclone
#      davinci-resolve
			papirus-icon-theme
			waybar
			nodejs
			aria
			v2ray
			v2ray-domain-list-community
			v2ray-geoip
			appimage-run
			scrcpy
			nomacs
			
		])
		++ ([zhumu]);
}
