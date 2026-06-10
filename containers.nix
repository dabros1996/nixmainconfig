{ config, pkgs, ... }:

{
  # Włączenie wirtualizacji (KVM/QEMU) i Libvirt
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

  # Włączenie i konfiguracja Dockera
  virtualisation.docker.enable = true;
  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };

  # Instalacja Docker Compose w systemie
  environment.systemPackages = with pkgs; [
    docker-compose
  ];

  # Dodaj swojego użytkownika do grup (zastąp 'twoja_nazwa_uzytkownika')
  users.users.dabrosnix = {
    extraGroups = [ "docker" "libvirtd" ];
  };
}
