let
  pkgs = import <nixpkgs> {};
  reqs = import ./requirements.nix {};
in
# nix has auto-packaging for python apps but taiga has no setup.py so we have to glue it ourselves :]
pkgs.stdenv.mkDerivation{ 
  name="taiga-back";
  src = pkgs.fetchFromGitHub {
    repo = "taiga-back";
    rev = "3.3.5";
    owner = "taigaio";
    sha256 = "00iqj3qi1ipcdl7bkw3fyvlw5955xyp3k2nwxdkvyhgkpp3jfzfq";
  };
  buildPhase=''
    mkdir $out/bin -p
    mkdir $out/share
    cp -r * $out/share
    cat <<EOF > $out/bin/start
    #!${pkgs.bash}/bin/bash
    set -eu
    echo PYTHONPATH=$PYTHONPATH:$out/share
    exec ${reqs.interpreter}/bin/python $out/share/manage.py "\$@"
    EOF
    chmod +x $out/bin/start
  '';
  installPhase="true";
}
