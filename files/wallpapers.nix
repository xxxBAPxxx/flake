{
  zen,
  lib,
  ...
}:

let
  listOfWallpapers = {
    # keep-sorted start block=yes newline_separated=yes
    "Mazda vocaloids" = {
      page = "https://wallhaven.cc/w/poyqx9";
      hash = "sha256-eX6Dp9MjmWoy/VwVmt1CJ16n4x4tz3MmbuIRJcKooqQ=";
      extension = "png";
    };

    "Nijika in Classroom" = {
      page = "https://wallhaven.cc/w/85wzyy";
      hash = "sha256-jUmSLJ9uXgpdgfU8/EtIRvCrIdwqe1HG5ciIRd9zUGM=";
      extension = "jpg";
    };

    "Silhouette" = {
      page = "https://wallhaven.cc/w/e86xlo";
      hash = "sha256-CaQLKhOLBoNd3AK4hysHVDSS8hb8o42F12tkeBBEJ7g=";
      extension = "png";
    };

    "Trainstation vocaloids" = {
      page = "https://wallhaven.cc/w/qrl18l";
      hash = "sha256-kZkqSGGKArLkkmACCi73Fydn1+SXRtPG1xds2yweQUA=";
      extension = "png";
    };

    # alike Man in Black
    "Woman in Vocaloids" = {
      page = "https://wallhaven.cc/w/k82p6d";
      hash = "sha256-wa98cjMHwllsUYTftkV/2P7YeIxUsoGKepClUCANJwY=";
      extension = "png";
    };
    # keep-sorted end
  };

  listOfTags = {
    "Stray" = "https://wallhaven.cc/tag/134796";
  };

in

{
  zen.flake-parts.default = {
    includes = [
      zen.custom.wallpapers
    ];

    wallpapers =
      {
        ...
      }:
      let
        process =
          {
            page,
            hash,
            extension,
          }:
          let
            id = lib.head (lib.match ".*/w/(.*)" page);
            sub = lib.substring 0 2 id;
          in
          {
            inherit page hash extension;
            full = "https://w.wallhaven.cc/full/${sub}/wallhaven-${id}.${extension}";
            small = "https://th.wallhaven.cc/small/${sub}/${id}.jpg";
          };
      in
      builtins.mapAttrs (_name: value: process value) listOfWallpapers;

    files =
      {
        config,
        ...
      }:
      {
        file."wallpapers.md" =
          let
            formatEntry =
              name: entry:
              lib.trim ''
                [**${name}**](${entry.page}) -> (_${entry.full}_)

                ![${name}](${entry.small})
              '';

            formatTag =
              name: url:
              lib.trim ''
                **${name}** -> (${url})
              '';
          in
          {
            text = ''
              # Wallpapers

              ${lib.concatStringsSep "\n\n" (lib.mapAttrsToList formatEntry config.wallpapers)}

              ## Tags

              ${lib.concatStringsSep "\n\n" (lib.mapAttrsToList formatTag listOfTags)}

              ## Total: ${toString (lib.length (lib.attrNames config.wallpapers))} wallpapers from https://wallhaven.cc
            '';
          };
      };

    legacyPackages =
      {
        pkgs,
        lib,
        config,
        ...
      }:
      let
        sanitize =
          name:
          lib.toLower (
            builtins.replaceStrings
              [
                " "
                ":"
                "~"
              ]
              [
                "-"
                ""
                "-"
              ]
              name
          );

        mkWallpapers =
          {
            colors ? [
              "151515"
              "1f1f1f"
              "d9bc8c"
              "8da3b9"
            ],
          }:
          let
            colorsStr = builtins.concatStringsSep " " colors;

            processOne =
              name:
              {
                full,
                hash,
                extension,
                ...
              }:
              let
                fileName = sanitize "${name}.${extension}";
                image = builtins.fetchurl {
                  name = fileName;
                  url = full;
                  sha256 = hash;
                };
              in
              pkgs.runCommandLocal "lutgen-${fileName}"
                {
                  buildInputs = [ pkgs.lutgen ];
                  inherit image colorsStr extension;
                }
                ''
                  lutgen apply "$image" -o "$out" -- $colorsStr
                '';

            processed = lib.mapAttrs processOne config.wallpapers;
          in
          (
            (lib.mapAttrs' (
              name: drv:
              let
                fileName = sanitize name;
                extension = config.wallpapers.${name}.extension;
                fullName = "${fileName}.${extension}";
              in
              lib.nameValuePair fileName (
                pkgs.runCommandLocal fullName { } ''
                  ln -s ${drv} $out
                ''
              )
            ) processed)
            // {
              _farmed = pkgs.linkFarm "images-farmed" (
                lib.mapAttrsToList (name: drv: {
                  name = "${sanitize name}.${config.wallpapers.${name}.extension}";
                  path = drv;
                }) processed
              );
            }
          );
      in
      {
        images = lib.makeOverridable mkWallpapers { };
      };
  };
}
