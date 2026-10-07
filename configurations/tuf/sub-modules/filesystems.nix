{
  ...
}:

{
  zen.hosts.tuf.nixos =
    {
      ...
    }:
    {
      fileSystems = {
        "/" = {
          device = "/dev/disk/by-uuid/51775aab-c80e-40ba-92d1-d09385a34ee4";
          fsType = "btrfs";
          options = [ "subvol=@" ];
        };

        "/boot" = {
          device = "/dev/disk/by-uuid/A9FD-4350";
          fsType = "vfat";
          options = [
            "fmask=0077"
            "dmask=0077"
          ];
        };

        "/home" = {
          device = "/dev/disk/by-uuid/51775aab-c80e-40ba-92d1-d09385a34ee4";
          fsType = "btrfs";
          options = [ "subvol=@home" ];
        };

        "/nix" = {
          device = "/dev/disk/by-uuid/51775aab-c80e-40ba-92d1-d09385a34ee4";
          fsType = "btrfs";
          options = [ "subvol=@nix" ];
        };

        "/var" = {
          device = "/dev/disk/by-uuid/51775aab-c80e-40ba-92d1-d09385a34ee4";
          fsType = "btrfs";
          options = [ "subvol=@var" ];
        };

        "/var/log" = {
          device = "/dev/disk/by-uuid/51775aab-c80e-40ba-92d1-d09385a34ee4";
          fsType = "btrfs";
          options = [
            "subvol=@log"
            "noatime"
          ];
        };

        "/persistent" = {
          device = "/dev/disk/by-uuid/51775aab-c80e-40ba-92d1-d09385a34ee4";
          fsType = "btrfs";
          options = [ "subvol=@persistent" ];
        };
      };

      swapDevices = [
        {
          device = "/dev/disk/by-uuid/487dbc74-8c1f-43a9-a625-9bcd7f8e3a1d";
        }
      ];
    };
}
