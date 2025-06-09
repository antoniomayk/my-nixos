{ pkgs, ... }:

{
  imports = [
    (import ./neovim.nix)
    (import ./sway.nix { inherit pkgs; })
  ];
}
