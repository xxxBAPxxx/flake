{
  zen,
  ...
}:

{
  zen.programs.terminal.zsh = {
    description = ''
      best shell
      needs upgrade/update
    '';

    includes = [
      zen.programs.terminal.zsh.plugins
      # zen.programs.terminal.zsh.shell-init
      zen.programs.terminal.starship
      zen.programs.terminal.zoxide
    ];

    user =
      {
        lib,
        config,
        user,
        ...
      }:
      {
        shell = lib.mkIf (user.shell == "zsh") config.programs.zsh.package;
      };

    nixos =
      {
        ...
      }:
      {
        programs.zsh.enable = true;
      };

    homeManager =
      {
        ...
      }:
      {
        programs.zsh = {
          enable = true;
        };
      };
  };
}
