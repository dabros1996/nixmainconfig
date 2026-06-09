{ config, pkgs, ... }:

{
  # 1. Install required Nerd Fonts for terminal icons & the theme package
  fonts.packages = with pkgs; [
    nerd-fonts.meslo-lg # Standard Powerlevel10k recommended font
  ];

  environment.systemPackages = with pkgs; [
    zsh-powerlevel10k
  ];

  # 2. Globally assign Zsh as the default shell for users
  users.defaultUserShell = pkgs.zsh;

  # 3. System-wide Zsh and Oh My Zsh module declarations
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;

    # Configure Oh My Zsh framework natively
    ohMyZsh = {
      enable = true;
      plugins = [ "git" "sudo" ];
    };

    # Inject the Powerlevel10k theme into the global initialization profile
    promptInit = ''
      # Fast-load prompt optimization script if available
      if [[ -r "''${XDG_CACHE_HOME:-''$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
        source "''${XDG_CACHE_HOME:-''$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
      fi

      # Source the theme package from the Nix store
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme

      # Source your local persistent configuration if it exists
      [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
    '';
  };
}
