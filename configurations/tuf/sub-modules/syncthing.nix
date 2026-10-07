{
  ...
}:

{
  zen.users.miko = {
    homeManager =
      {
        lib,
        config,
        ...
      }:
      {
        services.syncthing = {
          settings = {
            devices = {
              # keep-sorted start block=yes newline_separated=yes
              "nx809j" = {
                id = "%NX809J_ID%";
                autoAcceptFolders = true;
                compression = "always";
              };
              # keep-sorted end
            };

            folders = {
              # keep-sorted start block=yes newline_separated=yes
              "${config.xdg.userDirs.music}" = {
                id = lib.hashString "md5" "music";
                devices = [ "nx809j" ];
              };

              "${config.xdg.userDirs.publicShare}/synchron" = {
                id = lib.hashString "md5" "synchron";
                devices = [ "nx809j" ];
              };
              # keep-sorted end
            };
          };
        };
      };
  };
}
