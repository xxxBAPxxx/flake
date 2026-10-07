{
  ...
}:

{
  zen.programs.terminal.zsh.plugins = {
    homeManager =
      {
        pkgs,
        ...
      }:
      {
        home.packages = [
          pkgs.grc
        ];

        programs.zsh = {
          plugins =
            map
              (package: {
                inherit (package)
                  name
                  src
                  ;
              })
              [
                # keep-sorted start
                pkgs.zsh-fzf-tab
                pkgs.zsh-autocomplete
                pkgs.zsh-autosuggestions
                pkgs.zsh-syntax-highlighting
                # pkgs.fishPlugins.colored-man-pages
                # pkgs.fishPlugins.fishbang
                # pkgs.fishPlugins.fzf-fish
                # pkgs.fishPlugins.git-abbr
                # pkgs.fishPlugins.grc
                # pkgs.fishPlugins.pisces
                # pkgs.fishPlugins.puffer
                # keep-sorted end
              ];
        };
      };
  };
}