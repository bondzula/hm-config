{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    vimAlias = true;
    viAlias = true;
    withNodeJs = true;
    withPython3 = true;
    withRuby = false;

    extraPackages = with pkgs; [
      tree-sitter

      # JavaScript
      nodejs
      nodePackages.npm
      nodePackages.typescript

      lua

      # PHP
      php82
      php82Packages.composer
      php82Packages.phpstan

      # Nix
      deadnix
      nixfmt
      statix
    ];
  };
}
