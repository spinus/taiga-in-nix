let
  pkgs = import <nixpkgs> {};
in
with pkgs.dockerTools;

buildImage {
    name = "taiga-back";
    tag = "whatever";
    contents = import ./backend.nix ;
    runAsRoot = ''
      mkdir -p /data
    '';
    config = {
      Cmd = [ "/bin/redis-server" ];
      WorkingDir = "/mnt";
    };
}
