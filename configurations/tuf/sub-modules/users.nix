{
  ...
}:

{
  zen.hosts.tuf = {
    nixos =
      {
        ...
      }:
      {
        users.mutableUsers = false;

        # users.users.root = {
        #   hashedPasswordFile = config.sops.secrets."password/root".path;
        # };

        # sops.secrets = {
        #   "password/miko" = {
        #     neededForUsers = true;
        #   };

        #   "password/root" = {
        #     neededForUsers = true;
        #   };
        # };
      };
  };

  zen.users.miko = {
    user =
      {
        config,
        ...
      }:
      {
        hashedPassword = "$6$VIiLnSbWY77pbmtD$zqlWAjlCAkHPYl5Y93TziUSFdUfP8a5PfgqdZYoas/g1bZJorFsjw2r9PKDiQWDuuj7STpBGzC7bZwI2kTEEc1";

        extraGroups = [
          # keep-sorted start
          "audio"
          "deluge"
          "docker"
          "gamemode"
          "input"
          "libvirtd"
          "media"
          "networkmanager"
          "podman"
          "proxy-suite"
          "qbittorrent"
          "suwayomi"
          "terraria"
          "users"
          "video"
          "wheel"
          config.services.kubo.group
          # keep-sorted end
        ];
      };
  };
}
