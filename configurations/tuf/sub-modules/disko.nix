{
  ...
}:

{
  zen.hosts.tuf = {
    # Keep the layout in the host's NixOS configuration so disko and
    # nixos-install use the same devices and generated fileSystems.
    nixos =
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
                esp = {
                  label = "boot-efi";

                  size = "1G";
                  type = "EF00";

                  content = {
                    type = "filesystem";
                    format = "vfat";
                    mountpoint = "/boot";

                    mountOptions = [
                      "defaults"
                      "umask=0077"
                    ];
                  };
                };

                root = {
                  label = "nixos-${host.hostName}";

                  size = "100%";

                  content = {
                    type = "filesystem";
                    format = "ext4";
                    mountpoint = "/";
                  };
                };
              };
            };
          };
        };
      };
  };
}
