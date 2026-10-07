{
  ...
}:

{
  zen.hosts.tuf = {
    disko =
      {
        host,
        ...
      }:
      {
        disko.devices.disk = {
          "${baseNameOf host.device}" = {
            device = host.device;

            type = "disk";

            content = {
              type = "gpt";

              partitions = {
                ESP = {
                  size = "1G";
                  type = "EF00";

                  content = {
                    type = "filesystem";
                    format = "vfat";
                    mountpoint = "/boot";

                    mountOptions = [
                      "fmask=0077"
                      "dmask=0077"
                    ];
                  };
                };

                swap = {
                  size = "16G";

                  content = {
                    type = "swap";
                    resumeDevice = true;
                  };
                };

                root = {
                  size = "100%";

                  content = {
                    type = "btrfs";

                    mountOptions = [
                      "compress=zstd"
                      "noatime"
                    ];

                    subvolumes = {
                      "@" = {
                        mountpoint = "/";
                      };

                      "@home" = {
                        mountpoint = "/home";
                      };

                      "@nix" = {
                        mountpoint = "/nix";
                      };

                      "@var" = {
                        mountpoint = "/var";
                      };

                      "@log" = {
                        mountpoint = "/var/log";

                        mountOptions = [
                          "compress=zstd"
                          "noatime"
                        ];
                      };

                      "@persistent" = {
                        mountpoint = "/persistent";
                      };
                    };
                  };
                };
              };
            };
          };
        };
      };
  };
}
