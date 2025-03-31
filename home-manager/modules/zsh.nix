{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    defaultKeymap = "viins";
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      update = "sudo nixos-rebuild switch --flake /etc/nixos";
      k = "kubecolor";
      kak = "k apply -k .";
      kns = "kubens";
      ktx = "kubectx";
      nix-shell = "nix-shell --command zsh";
      ssh = "kitten ssh";
      wireshark = "sudo termshark";

      # TODO REMOVE:
      mipsy = "~/mipsy/target/debug/mipsy";
      sshcse = "ssh z5588665@login.cse.unsw.edu.au";
      sshcsepg = "ssh z5588665@vxdb02.cse.unsw.edu.au";
      sshcsefs = "sshfs -o idmap=user -C z5588665@login5.cse.unsw.edu.au: ~/unsw/cse";
      sshcseufs = "fusermount -zu ~/unsw/cse";
      tastytrade = "/etc/nixos/result/bin/tastytrade";
      code = "FLATPAK_ENABLE_SDK_EXT=openjdk8 flatpak run com.visualstudio.code";
    };
    initExtra = ''
      autoload -Uz compinit && compinit
      zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
      zstyle ':completion:*' menu select

      bindkey '^F' autosuggest-accept

      # Fix backspacing non-inserted characters in vim insert mode
      bindkey "^H" backward-delete-char
      bindkey "^?" backward-delete-char

      zmodload zsh/complist
      bindkey -M menuselect 'h' vi-backward-char
      bindkey -M menuselect 'k' vi-up-line-or-history
      bindkey -M menuselect 'l' vi-forward-char
      bindkey -M menuselect 'j' vi-down-line-or-history

      # Enable shell integration for mise
      eval "$(mise activate zsh)"

      # Case Insensitive autocomplete
      source <(kubectl completion zsh)
      compdef kubecolor=kubectl

    '';
  };
}
