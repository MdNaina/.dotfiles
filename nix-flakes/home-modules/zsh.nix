{ pkgs, ... }: {
  home.packages = [ pkgs.zsh ];
  programs = {
    zoxide.enable = true;
    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      shellAliases = {
        editNix = "nvim ~/repos/github/MdNaina/.dotfiles/nix-flakes/flake.nix";
        la = "ls -a";
        ll = "ls -l";
      };
      oh-my-zsh = {
        enable = true;
        plugins = [ "git" ];
      };
    };
  };
}
