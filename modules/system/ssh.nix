{ config, ... }:

{
  programs.ssh = {
    extraConfig = ''
      Host github.com
        IdentityFile /etc/ssh/github_key
        IdentitiesOnly yes
    '';
  };

  environment.etc."ssh/github_key" = {
    source = "/persist/secrets/github_key";
    mode = "0600";
  };
}
