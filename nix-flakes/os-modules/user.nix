{ pkgs, ... }: {
  users = {
    users.mdnaina = {
      isNormalUser = true;
      extraGroups = [ "wheel" "docker" ];
    };
    defaultUserShell = pkgs.zsh;
  };
}
