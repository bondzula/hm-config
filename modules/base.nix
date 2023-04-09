{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "bondzula";
  home.homeDirectory = "/home/bondzula";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "22.11";

  imports = [
    ./cli
  ];

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    nixpkgs-fmt
    mysql80
    bc
    curl
    wget
    unzip
    ffmpeg
    imagemagick
    terraform
    awscli
    ssm-session-manager-plugin
    httpie
    jq
    trash-cli
    cargo
    rustc
    nodejs
    nodePackages.pnpm
    gnumake
    gcc

    # Required for VS Code SSH
    vscode
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
