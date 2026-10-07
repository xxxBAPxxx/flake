{
  self,
  inputs,
  zen,
  ...
}:

{
  den.schema.host.imports = [
    (
      {
        lib,
        config,
        host,
        ...
      }:
      lib.mkIf (config.class == "nixos") {
        aspect = zen.hosts.${host.hostName};

        instantiate =
          {
            modules,
            ...
          }:
          inputs.nixpkgs.lib.nixosSystem {
            inherit
              modules
              ;

            lib = import ./_lib.nix {
              inherit
                inputs
                lib
                ;
            };

            specialArgs = {
              inherit
                self
                inputs
                ;
            };
          };
      }
    )
  ];
}
