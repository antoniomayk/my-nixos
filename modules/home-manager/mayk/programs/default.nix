{
  pkgs,
  theme,
  palette,
  ...
}:
{
  imports = [
    (import ./bash.nix { inherit palette; })
    (import ./bat.nix)
    (import ./firefox.nix)
    (import ./fzf.nix)
    (import ./ghostty.nix { inherit palette theme; })
    (import ./git.nix)
    (import ./neovide.nix { inherit theme; })
    (import ./neovim.nix { inherit pkgs; })
    (import ./readline.nix)
    (import ./rofi.nix { inherit pkgs theme; })
    (import ./swaylock.nix { inherit pkgs theme; })
    (import ./waybar.nix { inherit theme; })
    (import ./zathura.nix { inherit palette theme; })
    (import ./zoxide.nix)
  ];
}
