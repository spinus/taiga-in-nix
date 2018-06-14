# generated using pypi2nix tool (version: 1.8.1)
# See more at: https://github.com/garbas/pypi2nix
#
# COMMAND:
#   pypi2nix -V 3.6 -E pkgconfig zlib libjpeg openjpeg libtiff freetype lcms2 libwebp tcl -E zlib -E gcc -E libffi -E postgresql -E openssl -E libxml2 -E libxslt -r /tmp/tmp.xbK0yGZTDG.txt -v
#

{ pkgs ? import <nixpkgs> {}
}:

let

  inherit (pkgs) makeWrapper;
  inherit (pkgs.stdenv.lib) fix' extends inNixShell;

  pythonPackages =
  import "${toString pkgs.path}/pkgs/top-level/python-packages.nix" {
    inherit pkgs;
    inherit (pkgs) stdenv;
    python = pkgs.python36;
    # patching pip so it does not try to remove files when running nix-shell
    overrides =
      self: super: {
        bootstrapped-pip = super.bootstrapped-pip.overrideDerivation (old: {
          patchPhase = old.patchPhase + ''
            sed -i               -e "s|paths_to_remove.remove(auto_confirm)|#paths_to_remove.remove(auto_confirm)|"                -e "s|self.uninstalled = paths_to_remove|#self.uninstalled = paths_to_remove|"                  $out/${pkgs.python35.sitePackages}/pip/req/req_install.py
          '';
        });
      };
  };

  commonBuildInputs = with pkgs; [ pkgconfig zlib libjpeg openjpeg libtiff freetype lcms2 libwebp tcl zlib gcc libffi postgresql openssl libxml2 libxslt ];
  commonDoCheck = false;

  withPackages = pkgs':
    let
      pkgs = builtins.removeAttrs pkgs' ["__unfix__"];
      interpreter = pythonPackages.buildPythonPackage {
        name = "python36-interpreter";
        buildInputs = [ makeWrapper ] ++ (builtins.attrValues pkgs);
        buildCommand = ''
          mkdir -p $out/bin
          ln -s ${pythonPackages.python.interpreter}               $out/bin/${pythonPackages.python.executable}
          for dep in ${builtins.concatStringsSep " "               (builtins.attrValues pkgs)}; do
            if [ -d "$dep/bin" ]; then
              for prog in "$dep/bin/"*; do
                if [ -f $prog ]; then
                  ln -s $prog $out/bin/`basename $prog`
                fi
              done
            fi
          done
          for prog in "$out/bin/"*; do
            wrapProgram "$prog" --prefix PYTHONPATH : "$PYTHONPATH"
          done
          pushd $out/bin
          ln -s ${pythonPackages.python.executable} python
          ln -s ${pythonPackages.python.executable}               python3
          popd
        '';
        passthru.interpreter = pythonPackages.python;
      };
    in {
      __old = pythonPackages;
      inherit interpreter;
      mkDerivation = pythonPackages.buildPythonPackage;
      packages = pkgs;
      overrideDerivation = drv: f:
        pythonPackages.buildPythonPackage (drv.drvAttrs // f drv.drvAttrs //                                            { meta = drv.meta; });
      withPackages = pkgs'':
        withPackages (pkgs // pkgs'');
    };

  python = withPackages {};

  generated = self: {

    "CairoSVG" = python.mkDerivation {
      name = "CairoSVG-2.0.3";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/88/30/63f5899306fc9e78888cb8453b08012fd67f0363d0b82e349316325690d6/CairoSVG-2.0.3.tar.gz"; sha256 = "d2da5aaa31ded26affd5cdffc371ec4cc48800bc2d822a9c28504360482418a1"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."Pillow"
      self."cairocffi"
      self."cssselect"
      self."lxml"
      self."tinycss"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://www.cairosvg.org/";
        license = licenses.lgpl3Plus;
        description = "A Simple SVG Converter based on Cairo";
      };
    };



    "Django" = python.mkDerivation {
      name = "Django-1.11.2";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/c0/31/4bffd9183066eea645430114419c30b030b599320da8246701b81c6a78d2/Django-1.11.2.tar.gz"; sha256 = "3c5b070482df4f9e5750539dc1824d353729ee423fd410c579b8cd3dea5b0617"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."pytz"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://www.djangoproject.com/";
        license = licenses.bsdOriginal;
        description = "A high-level Python Web framework that encourages rapid development and clean, pragmatic design.";
      };
    };



    "Jinja2" = python.mkDerivation {
      name = "Jinja2-2.9.6";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/90/61/f820ff0076a2599dd39406dcb858ecb239438c02ce706c8e91131ab9c7f1/Jinja2-2.9.6.tar.gz"; sha256 = "ddaa01a212cd6d641401cb01b605f4a4d9f37bfc93043d7f760ec70fb99ff9ff"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."MarkupSafe"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://jinja.pocoo.org/";
        license = licenses.bsdOriginal;
        description = "A small but fast and easy to use stand-alone template engine written in pure python.";
      };
    };



    "Markdown" = python.mkDerivation {
      name = "Markdown-2.6.11";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/b3/73/fc5c850f44af5889192dff783b7b0d8f3fe8d30b65c8e3f78f8f0265fecf/Markdown-2.6.11.tar.gz"; sha256 = "a856869c7ff079ad84a3e19cd87a64998350c2b94e9e08e44270faef33400f81"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://Python-Markdown.github.io/";
        license = licenses.bsdOriginal;
        description = "Python implementation of Markdown.";
      };
    };



    "MarkupSafe" = python.mkDerivation {
      name = "MarkupSafe-1.0";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/4d/de/32d741db316d8fdb7680822dd37001ef7a448255de9699ab4bfcbdf4172b/MarkupSafe-1.0.tar.gz"; sha256 = "a6be69091dac236ea9c6bc7d012beab42010fa914c459791d627dad4910eb665"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://github.com/pallets/markupsafe";
        license = licenses.bsdOriginal;
        description = "Implements a XML/HTML/XHTML Markup safe string for Python";
      };
    };



    "Pillow" = python.mkDerivation {
      name = "Pillow-4.1.1";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/93/73/66854f63b1941aad9af18a1de59f9cf95ad1a87c801540222e332f6688d7/Pillow-4.1.1.tar.gz"; sha256 = "00b6a5f28d00f720235a937ebc2f50f4292a5c7e2d6ab9a8b26153b625c4f431"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."olefile"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://python-pillow.org";
        license = "Standard PIL License";
        description = "Python Imaging Library (Fork)";
      };
    };



    "PyJWT" = python.mkDerivation {
      name = "PyJWT-1.5.0";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/53/d1/bc6a0296a4a63277c45ab22f4b4a58a0d2ada12d6d60905dbdc40989d8fd/PyJWT-1.5.0.tar.gz"; sha256 = "fd182b728d13f04c289d9b2623d09256d356c9b4a6778018001454a954d7c54b"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."cryptography"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://github.com/jpadilla/pyjwt";
        license = licenses.mit;
        description = "JSON Web Token implementation in Python";
      };
    };



    "Pygments" = python.mkDerivation {
      name = "Pygments-2.2.0";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/71/2a/2e4e77803a8bd6408a2903340ac498cb0a2181811af7c9ec92cb70b0308a/Pygments-2.2.0.tar.gz"; sha256 = "dbae1046def0efb574852fab9e90209b23f556367b5a320c0bcb871c77c3e8cc"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pygments.org/";
        license = licenses.bsdOriginal;
        description = "Pygments is a syntax highlighting package written in Python.";
      };
    };



    "Unidecode" = python.mkDerivation {
      name = "Unidecode-0.4.20";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/ba/64/410af95d27f2a8824112d17ed41ea7ce6d2cbc8a4832c2e548d3408fad0a/Unidecode-0.04.20.tar.gz"; sha256 = "ed4418b4b1b190487753f1cca6299e8076079258647284414e6d607d1f8a00e0"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "";
        license = licenses.gpl2Plus;
        description = "ASCII transliterations of Unicode text";
      };
    };



    "amqp" = python.mkDerivation {
      name = "amqp-2.1.4";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/23/39/06bb8bd31e78962675f696498f7821f5dbd11aa0919c5a811d83a0e02609/amqp-2.1.4.tar.gz"; sha256 = "1378cc14afeb6c2850404f322d03dec0082d11d04bdcb0360e1b10d4e6e77ef9"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."vine"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://github.com/celery/py-amqp";
        license = licenses.bsdOriginal;
        description = "Low-level AMQP client for Python (fork of amqplib).";
      };
    };



    "asana" = python.mkDerivation {
      name = "asana-0.6.5";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/17/b9/c8b1977f1a5b27f87b6c5f99feca16f3c240a87b446d5362518302c04879/asana-0.6.5.tar.gz"; sha256 = "eab8d24c2a4670b541b75da2f4bf5b995fe71559c1338da53ce9039f7b19c9a0"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."requests"
      self."requests-oauthlib"
      self."six"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://github.com/asana/python-asana";
        license = licenses.mit;
        description = "Asana API client";
      };
    };



    "asn1crypto" = python.mkDerivation {
      name = "asn1crypto-0.24.0";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/fc/f1/8db7daa71f414ddabfa056c4ef792e1461ff655c2ae2928a2b675bfed6b4/asn1crypto-0.24.0.tar.gz"; sha256 = "9d5c20441baf0cb60a4ac34cc447c6c189024b6b4c6cd7877034f4965c464e49"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/wbond/asn1crypto";
        license = licenses.mit;
        description = "Fast ASN.1 parser and serializer with definitions for private keys, public keys, certificates, CRL, OCSP, CMS, PKCS#3, PKCS#7, PKCS#8, PKCS#12, PKCS#5, X.509 and TSP";
      };
    };



    "billiard" = python.mkDerivation {
      name = "billiard-3.5.0.3";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/39/ac/f5571210cca2e4f4532e38aaff242f26c8654c5e2436bee966c230647ccc/billiard-3.5.0.3.tar.gz"; sha256 = "1d7b22bdc47aa52841120fcd22a74ae4fc8c13e9d3935643098184f5788c3ce6"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://github.com/celery/billiard";
        license = licenses.bsdOriginal;
        description = "Python multiprocessing fork with improvements and bugfixes";
      };
    };



    "bleach" = python.mkDerivation {
      name = "bleach-2.0.0";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/1e/67/2562affb99e194cb4b0c0b88e661650d065fcf452d1108116a9530ed9cad/bleach-2.0.0.tar.gz"; sha256 = "b9522130003e4caedf4f00a39c120a906dcd4242329c1c8f621f5370203cbc30"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."html5lib"
      self."six"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://github.com/mozilla/bleach";
        license = "License :: OSI Approved :: Apache Software License";
        description = "An easy safelist-based HTML-sanitizing tool.";
      };
    };



    "cairocffi" = python.mkDerivation {
      name = "cairocffi-0.8.1";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/7a/2f/78179fea3413322fd20be407897738e5569e876e7cb6e4647a79b1ffd8dd/cairocffi-0.8.1.tar.gz"; sha256 = "47eb1c53d15041dda983e0004b249123bb18edb10dbff3742d039fedd41e6778"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."cffi"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/SimonSapin/cairocffi";
        license = licenses.bsdOriginal;
        description = "cffi-based cairo bindings for Python";
      };
    };



    "celery" = python.mkDerivation {
      name = "celery-4.0.2";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/b2/b7/888565f3e955473247aef86174db5121d16de6661b69bd8f3d10aff574f6/celery-4.0.2.tar.gz"; sha256 = "e3d5a6c56a73ff8f2ddd4d06dc37f4c2afe4bb4da7928b884d0725ea865ef54d"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."Django"
      self."billiard"
      self."kombu"
      self."pytz"
      self."redis"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://celeryproject.org";
        license = licenses.bsdOriginal;
        description = "Distributed Task Queue.";
      };
    };



    "cffi" = python.mkDerivation {
      name = "cffi-1.11.5";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/e7/a7/4cd50e57cc6f436f1cc3a7e8fa700ff9b8b4d471620629074913e3735fb2/cffi-1.11.5.tar.gz"; sha256 = "e90f17980e6ab0f3c2f3730e56d1fe9bcba1891eeea58966e89d352492cc74f4"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."pycparser"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://cffi.readthedocs.org";
        license = licenses.mit;
        description = "Foreign Function Interface for Python calling C code.";
      };
    };



    "cryptography" = python.mkDerivation {
      name = "cryptography-1.9";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/2a/0c/31bd69469e90035381f0197b48bf71032991d9f07a7e444c311b4a23a3df/cryptography-1.9.tar.gz"; sha256 = "5518337022718029e367d982642f3e3523541e098ad671672a90b82474c84882"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."asn1crypto"
      self."cffi"
      self."idna"
      self."pytz"
      self."six"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/pyca/cryptography";
        license = licenses.bsdOriginal;
        description = "cryptography is a package which provides cryptographic recipes and primitives to Python developers.";
      };
    };



    "cssselect" = python.mkDerivation {
      name = "cssselect-1.0.3";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/52/ea/f31e1d2e9eb130fda2a631e22eac369dc644e8807345fbed5113f2d6f92b/cssselect-1.0.3.tar.gz"; sha256 = "066d8bc5229af09617e24b3ca4d52f1f9092d9e061931f4184cd572885c23204"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/scrapy/cssselect";
        license = licenses.bsdOriginal;
        description = "cssselect parses CSS3 Selectors and translates them to XPath 1.0";
      };
    };



    "cssutils" = python.mkDerivation {
      name = "cssutils-1.0.2";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/5c/0b/c5f29d29c037e97043770b5e7c740b6252993e4b57f029b3cd03c78ddfec/cssutils-1.0.2.tar.gz"; sha256 = "a2fcf06467553038e98fea9cfe36af2bf14063eb147a70958cfcaa8f5786acaf"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://cthedot.de/cssutils/";
        license = licenses.lgpl2;
        description = "A CSS Cascading Style Sheets library for Python";
      };
    };



    "diff-match-patch" = python.mkDerivation {
      name = "diff-match-patch-20121119";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/22/82/46eaeab04805b4fac17630b59f30c4f2c8860988bcefd730ff4f1992908b/diff-match-patch-20121119.tar.gz"; sha256 = "9dba5611fbf27893347349fd51cc1911cb403682a7163373adacc565d11e2e4c"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://code.google.com/p/google-diff-match-patch/";
        license = "License :: OSI Approved :: Apache Software License";
        description = "The Diff Match and Patch libraries offer robust algorithms to perform the operations required for synchronizing plain text.";
      };
    };



    "django-ipware" = python.mkDerivation {
      name = "django-ipware-1.1.6";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/94/c6/b08db9d173eb87fef85301b48b8202d969f36aad332f25e85abf7e6ce733/django-ipware-1.1.6.tar.gz"; sha256 = "93a90f9dd8caf2c633172aa8c8ba4e76e2b44f92a6942fa35e7624281e81ea03"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/un33k/django-ipware";
        license = licenses.mit;
        description = "A Django utility application that returns client's real IP address";
      };
    };



    "django-jinja" = python.mkDerivation {
      name = "django-jinja-2.3.1";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/8a/c3/e92403a4bf9b8c2b6f2bbd58ebb238dfcd5b8dc12950714d6ffcf5338ec3/django-jinja-2.3.1.tar.gz"; sha256 = "ebfde44cb716e57a9cdff6c1a4935fc49c7419ea4cd0b2b89bcecc696b9c0c86"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."Django"
      self."Jinja2"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/niwinz/django-jinja";
        license = licenses.bsdOriginal;
        description = "Jinja2 templating language integrated in Django.";
      };
    };



    "django-pglocks" = python.mkDerivation {
      name = "django-pglocks-1.0.2";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/a0/43/ee0a6215a992026ba3961136919a8ca56a9f0529430d486682606c07e91d/django-pglocks-1.0.2.tar.gz"; sha256 = "9405ee54bbf157bb16b814f20ea7ad9d82d5cf26f9bf3ea8e3a71032179844cf"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/Xof/django-pglocks";
        license = licenses.mit;
        description = "django_pglocks provides useful context managers for advisory locks for PostgreSQL.";
      };
    };



    "django-picklefield" = python.mkDerivation {
      name = "django-picklefield-0.3.2";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/9c/22/602e6d010248786d72b70c7ca16b0d19ec513897a39861a957a092a77b08/django-picklefield-0.3.2.tar.gz"; sha256 = "fab48a427c6310740755b242128f9300283bef159ffee42d3231a274c65d9ae2"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://github.com/gintas/django-picklefield";
        license = licenses.mit;
        description = "Pickled object field for Django";
      };
    };



    "django-sampledatahelper" = python.mkDerivation {
      name = "django-sampledatahelper-0.4.1";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/2b/fe/e8ef20ee17dcd5d4df96c36dcbcaca7a79d6a2f8dc319f4e25107e000859/django-sampledatahelper-0.4.1.tar.gz"; sha256 = "96d0a599054979eb9669d44a1735236da42d56be0c45d4bcd34c2a3acefb259d"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."Django"
      self."sampledata"
      self."six"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/kaleidos/django-sampledatahelper";
        license = licenses.bsdOriginal;
        description = "Helper class for generate sampledata";
      };
    };



    "django-sites" = python.mkDerivation {
      name = "django-sites-0.9";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/67/6b/1b814292d71d32f0380fb6256f639cf154227b753184f83f900c4ccfe3ea/django-sites-0.9.tar.gz"; sha256 = "fa1470bd72be589f3891b7cd28dd2d782d8b34539665d9334e49154566f3d916"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."Django"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/niwinz/django-sites";
        license = licenses.bsdOriginal;
        description = "Alternative implementation of django sites framework";
      };
    };



    "django-sr" = python.mkDerivation {
      name = "django-sr-0.0.4";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/3b/da/7d19c3d34a0f7180530733abdd0bbd0742de4a0fce51883a0e7f65ae6a4f/django-sr-0.0.4.tar.gz"; sha256 = "3586b852ae8af1b4b2796590534b0b867b523f47a5779b2ccb6ce010efc57e34"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."Django"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/jespino/django-sr";
        license = licenses.bsdOriginal;
        description = "Django settings resolver.";
      };
    };



    "djmail" = python.mkDerivation {
      name = "djmail-1.0.1";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/b0/dc/129d20791029f8ec95b57227d164c82e67adf44f57173a68783ba12e06f0/djmail-1.0.1.tar.gz"; sha256 = "370f57230bf79004840ddd1cb8150a5b7676b2aa14bc5b62027106cb708a47a0"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/bameda/djmail";
        license = licenses.bsdOriginal;
        description = "Simple, powerful and non-obstructive django email middleware.";
      };
    };



    "docopt" = python.mkDerivation {
      name = "docopt-0.6.2";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/a2/55/8f8cab2afd404cf578136ef2cc5dfb50baa1761b68c9da1fb1e4eed343c9/docopt-0.6.2.tar.gz"; sha256 = "49b3a825280bd66b3aa83585ef59c4a8c82f2c8a522dbe754a8bc8d08c85c491"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://docopt.org";
        license = licenses.mit;
        description = "Pythonic argument parser, that will make you smile";
      };
    };



    "easy-thumbnails" = python.mkDerivation {
      name = "easy-thumbnails-2.4.1";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/f1/bd/87a8add6021b0cdd248d6c594e0b717a9b6e9dc48166ade9934948bf223d/easy-thumbnails-2.4.1.tar.gz"; sha256 = "5cc51c6ec7de110355d0f8cd56c9ede6e2949e87c2fcb34bc864a20ecd424270"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."Django"
      self."Pillow"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://github.com/SmileyChris/easy-thumbnails";
        license = licenses.bsdOriginal;
        description = "Easy thumbnails for Django";
      };
    };



    "fn" = python.mkDerivation {
      name = "fn-0.4.3";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/a2/32/9d184dc2e8225af558e155a3865d610df8533d5d48a2ed5943bf8a30a137/fn-0.4.3.tar.gz"; sha256 = "f8cd80cdabf15367a2f07e7a9951fdc013d7200412743d85b88f2c896c95bada"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/kachayev/fn.py";
        license = "Copyright 2013 Alexey Kachayev";
        description = "Implementation of missing features to enjoy functional programming in Python";
      };
    };



    "future" = python.mkDerivation {
      name = "future-0.16.0";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/00/2b/8d082ddfed935f3608cc61140df6dcbf0edea1bc3ab52fb6c29ae3e81e85/future-0.16.0.tar.gz"; sha256 = "e39ced1ab767b5936646cedba8bcce582398233d6a627067d4c6a454c90cfedb"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://python-future.org";
        license = licenses.mit;
        description = "Clean single-source support for Python 3 and 2";
      };
    };



    "gunicorn" = python.mkDerivation {
      name = "gunicorn-19.7.1";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/30/3a/10bb213cede0cc4d13ac2263316c872a64bf4c819000c8ccd801f1d5f822/gunicorn-19.7.1.tar.gz"; sha256 = "eee1169f0ca667be05db3351a0960765620dad53f53434262ff8901b68a1b622"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://gunicorn.org";
        license = licenses.mit;
        description = "WSGI HTTP Server for UNIX";
      };
    };



    "html5lib" = python.mkDerivation {
      name = "html5lib-1.0.1";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/85/3e/cf449cf1b5004e87510b9368e7a5f1acd8831c2d6691edd3c62a0823f98f/html5lib-1.0.1.tar.gz"; sha256 = "66cb0dcfdbbc4f9c3ba1a63fdb511ffdbd4f513b2b6d81b80cd26ce6b3fb3736"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."lxml"
      self."six"
      self."webencodings"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/html5lib/html5lib-python";
        license = licenses.mit;
        description = "HTML parser based on the WHATWG HTML specification";
      };
    };



    "idna" = python.mkDerivation {
      name = "idna-2.5";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/d8/82/28a51052215014efc07feac7330ed758702fc0581347098a81699b5281cb/idna-2.5.tar.gz"; sha256 = "3cb5ce08046c4e3a560fc02f138d0ac63e00f8ce5901a56b32ec8b7994082aab"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/kjd/idna";
        license = licenses.bsdOriginal;
        description = "Internationalized Domain Names in Applications (IDNA)";
      };
    };



    "kombu" = python.mkDerivation {
      name = "kombu-4.0.2";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/c7/76/58c655a80bf08b703478ce673ed4e3029297105951863b73030d45b06b42/kombu-4.0.2.tar.gz"; sha256 = "d0fc6f2a36610a308f838db4b832dad79a681b516ac1d1a1f9d42edb58cc11a2"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."amqp"
      self."redis"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://kombu.readthedocs.io";
        license = licenses.bsdOriginal;
        description = "Messaging library for Python.";
      };
    };



    "lxml" = python.mkDerivation {
      name = "lxml-3.8.0";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/20/b3/9f245de14b7696e2d2a386c0b09032a2ff6625270761d6543827e667d8de/lxml-3.8.0.tar.gz"; sha256 = "736f72be15caad8116891eb6aa4a078b590d231fdc63818c40c21624ac71db96"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."cssselect"
      self."html5lib"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://lxml.de/";
        license = licenses.bsdOriginal;
        description = "Powerful and Pythonic XML processing library combining libxml2/libxslt with the ElementTree API.";
      };
    };



    "netaddr" = python.mkDerivation {
      name = "netaddr-0.7.19";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/0c/13/7cbb180b52201c07c796243eeff4c256b053656da5cfe3916c3f5b57b3a0/netaddr-0.7.19.tar.gz"; sha256 = "38aeec7cdd035081d3a4c306394b19d677623bf76fa0913f6695127c7753aefd"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/drkjam/netaddr/";
        license = licenses.bsdOriginal;
        description = "A network address manipulation library for Python";
      };
    };



    "oauthlib" = python.mkDerivation {
      name = "oauthlib-2.1.0";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/df/5f/3f4aae7b28db87ddef18afed3b71921e531ca288dc604eb981e9ec9f8853/oauthlib-2.1.0.tar.gz"; sha256 = "ac35665a61c1685c56336bda97d5eefa246f1202618a1d6f34fccb1bdd404162"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."PyJWT"
      self."cryptography"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/oauthlib/oauthlib";
        license = licenses.bsdOriginal;
        description = "A generic, spec-compliant, thorough implementation of the OAuth request-signing logic";
      };
    };



    "olefile" = python.mkDerivation {
      name = "olefile-0.45.1";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/d3/8a/e0f0e56d6a542dd987f9290ef7b5164636ee597ce8c2932c19c78292d5ec/olefile-0.45.1.zip"; sha256 = "2b6575f5290de8ab1086f8c5490591f7e0885af682c7c1793bdaf6e64078d385"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://www.decalage.info/python/olefileio";
        license = licenses.bsdOriginal;
        description = "Python package to parse, read and write Microsoft OLE2 files (Structured Storage or Compound Document, Microsoft Office) - Improved version of the OleFileIO module from PIL, the Python Image Library.";
      };
    };



    "premailer" = python.mkDerivation {
      name = "premailer-3.0.1";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/73/2e/bc055726855f2416e5b9ede631bd16d69b0366d425befb83048c600b492b/premailer-3.0.1.tar.gz"; sha256 = "4e71cc09ad1438f827d1070ffac54ceb3a6a07c995fa82cb34c1ef163adeb432"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."cssselect"
      self."cssutils"
      self."lxml"
      self."requests"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://github.com/peterbe/premailer";
        license = licenses.psfl;
        description = "Turns CSS blocks into style attributes";
      };
    };



    "psd-tools" = python.mkDerivation {
      name = "psd-tools-1.4";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/21/b2/cba69da51d30d2228ae1efbc9ed1d9f22e1bfaa7125dca20c0b66855f776/psd-tools-1.4.tar.gz"; sha256 = "1a8dd69783c84217f3a25938916c289e5653543c5610e9013769520e8bd65b3c"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."docopt"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/kmike/psd-tools";
        license = licenses.mit;
        description = "Python package for working with Adobe Photoshop PSD files";
      };
    };



    "psycopg2" = python.mkDerivation {
      name = "psycopg2-2.7.1";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/f8/e9/5793369ce8a41bf5467623ded8d59a434dfef9c136351aca4e70c2657ba0/psycopg2-2.7.1.tar.gz"; sha256 = "86c9355f5374b008c8479bc00023b295c07d508f7c3b91dbd2e74f8925b1d9c6"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://initd.org/psycopg/";
        license = licenses.lgpl2;
        description = "psycopg2 - Python-PostgreSQL Database Adapter";
      };
    };



    "pycparser" = python.mkDerivation {
      name = "pycparser-2.18";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/8c/2d/aad7f16146f4197a11f8e91fb81df177adcc2073d36a17b1491fd09df6ed/pycparser-2.18.tar.gz"; sha256 = "99a8ca03e29851d96616ad0404b4aad7d9ee16f25c9f9708a11faf2810f7b226"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/eliben/pycparser";
        license = licenses.bsdOriginal;
        description = "C parser in Python";
      };
    };



    "pycryptodomex" = python.mkDerivation {
      name = "pycryptodomex-3.6.1";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/6a/c4/21d55c2bf30995847406cb1a737d4ae5e19615eca39c9258f0548b5656f1/pycryptodomex-3.6.1.tar.gz"; sha256 = "82b758f870c8dd859f9b58bc9cff007403b68742f9e0376e2cbd8aa2ad3baa83"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://www.pycryptodome.org";
        license = licenses.bsdOriginal;
        description = "Cryptographic library for Python";
      };
    };



    "pyjwkest" = python.mkDerivation {
      name = "pyjwkest-1.3.2";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/b7/57/b02a875f75128e1f124b214c2140cc0b006145fdd19caf8125a68d99ab0d/pyjwkest-1.3.2.tar.gz"; sha256 = "2d91ecc56952edb14efe686b395d8a86f921461209578b45fc7ca85a35d73987"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."future"
      self."pycryptodomex"
      self."requests"
      self."six"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "";
        license = licenses.asl20;
        description = "Python implementation of JWT, JWE, JWS and JWK";
      };
    };



    "python-dateutil" = python.mkDerivation {
      name = "python-dateutil-2.6.0";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/51/fc/39a3fbde6864942e8bb24c93663734b74e281b984d1b8c4f95d64b0c21f6/python-dateutil-2.6.0.tar.gz"; sha256 = "62a2f8df3d66f878373fd0072eacf4ee52194ba302e00082828e0d263b0418d2"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."six"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://dateutil.readthedocs.io";
        license = licenses.bsdOriginal;
        description = "Extensions to the standard Python datetime module";
      };
    };



    "python-magic" = python.mkDerivation {
      name = "python-magic-0.4.13";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/65/0b/c6b31f686420420b5a16b24a722fe980724b28d76f65601c9bc324f08d02/python-magic-0.4.13.tar.gz"; sha256 = "604eace6f665809bebbb07070508dfa8cabb2d7cb05be9a56706c60f864f1289"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://github.com/ahupp/python-magic";
        license = licenses.mit;
        description = "File type identification using libmagic";
      };
    };



    "pytz" = python.mkDerivation {
      name = "pytz-2017.2";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/a4/09/c47e57fc9c7062b4e83b075d418800d322caa87ec0ac21e6308bd3a2d519/pytz-2017.2.zip"; sha256 = "f5c056e8f62d45ba8215e5cb8f50dfccb198b4b9fbea8500674f3443e4689589"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pythonhosted.org/pytz";
        license = licenses.mit;
        description = "World timezone definitions, modern and historical";
      };
    };



    "raven" = python.mkDerivation {
      name = "raven-6.1.0";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/ee/82/9a85650c174920f5bd260b8138a1db7190156e55193b0a1d03d2fa7a2811/raven-6.1.0.tar.gz"; sha256 = "02cabffb173b99d860a95d4908e8b1864aad1b8452146e13fd7e212aa576a884"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."celery"
      self."pytz"
      self."requests"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/getsentry/raven-python";
        license = licenses.bsdOriginal;
        description = "Raven is a client for Sentry (https://getsentry.com)";
      };
    };



    "redis" = python.mkDerivation {
      name = "redis-2.10.5";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/68/44/5efe9e98ad83ef5b742ce62a15bea609ed5a0d1caf35b79257ddb324031a/redis-2.10.5.tar.gz"; sha256 = "5dfbae6acfc54edf0a7a415b99e0b21c0a3c27a7f787b292eea727b1facc5533"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://github.com/andymccurdy/redis-py";
        license = licenses.mit;
        description = "Python client for Redis key-value store";
      };
    };



    "requests" = python.mkDerivation {
      name = "requests-2.14.2";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/72/46/4abc3f5aaf7bf16a52206bb0c68677a26c216c1e6625c78c5aef695b5359/requests-2.14.2.tar.gz"; sha256 = "a274abba399a23e8713ffd2b5706535ae280ebe2b8069ee6a941cb089440d153"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."cryptography"
      self."idna"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://python-requests.org";
        license = licenses.asl20;
        description = "Python HTTP for Humans.";
      };
    };



    "requests-oauthlib" = python.mkDerivation {
      name = "requests-oauthlib-0.6.2";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/cc/31/4d86cc71606ff8121267e732ca4dda5b082f14d57115783a575f26a7b957/requests-oauthlib-0.6.2.tar.gz"; sha256 = "161ec8aaa360befac7079bcf20dc2a3993d1ddef19bc21d8118232a98f716e7a"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."oauthlib"
      self."requests"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/requests/requests-oauthlib";
        license = licenses.bsdOriginal;
        description = "OAuthlib authentication support for Requests.";
      };
    };



    "sampledata" = python.mkDerivation {
      name = "sampledata-0.3.7";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/c8/2a/47577aa3b9038cdd1ab263ede01d497f9ceed5b50ac99642550a17bbcaff/sampledata-0.3.7.tar.gz"; sha256 = "b06916ef010d3c1a9db8aa314a144f24ad421f28597ff8c568603c451391a2cf"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."pytz"
      self."six"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/jespino/sampledata";
        license = licenses.bsdOriginal;
        description = "Helper class for generate sample data";
      };
    };



    "serpy" = python.mkDerivation {
      name = "serpy-0.1.1";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/6e/40/957005bc5f7996dcbf0ceedb302c4dc58fb9d2cceb5e2c3eb8a7f3c163e4/serpy-0.1.1.tar.gz"; sha256 = "b1481f8cb93d767b23903d1df6cc0a7120cb0694095b6695eb78d9d453b23c65"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."six"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/clarkduvall/serpy";
        license = licenses.mit;
        description = "ridiculously fast object serialization";
      };
    };



    "six" = python.mkDerivation {
      name = "six-1.10.0";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/b3/b2/238e2590826bfdd113244a40d9d3eb26918bd798fc187e2360a8367068db/six-1.10.0.tar.gz"; sha256 = "105f8d68616f8248e24bf0e9372ef04d3cc10104f1980f54d57b2ce73a5ad56a"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pypi.python.org/pypi/six/";
        license = licenses.mit;
        description = "Python 2 and 3 compatibility utilities";
      };
    };



    "tinycss" = python.mkDerivation {
      name = "tinycss-0.4";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/05/59/af583fff6236c7d2f94f8175c40ce501dcefb8d1b42e4bb7a2622dff689e/tinycss-0.4.tar.gz"; sha256 = "12306fb50e5e9e7eaeef84b802ed877488ba80e35c672867f548c0924a76716e"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://tinycss.readthedocs.io/";
        license = licenses.bsdOriginal;
        description = "tinycss is a complete yet simple CSS parser for Python.";
      };
    };



    "versiontools" = python.mkDerivation {
      name = "versiontools-1.9.1";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/37/a0/2de15402f69bc054fd57d1ef7278a52a9be474682e374d6bc60abde27f8f/versiontools-1.9.1.tar.gz"; sha256 = "a969332887a18a9c98b0df0ea4d4ca75972f24ca94f06fb87d591377e83414f6"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://launchpad.net/versiontools";
        license = licenses.lgpl2;
        description = "Smart replacement for plain tuple used in __version__";
      };
    };



    "vine" = python.mkDerivation {
      name = "vine-1.1.4";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/32/23/36284986e011f3c130d802c3c66abd8f1aef371eae110ddf80c5ae22e1ff/vine-1.1.4.tar.gz"; sha256 = "52116d59bc45392af9fdd3b75ed98ae48a93e822cee21e5fda249105c59a7a72"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://github.com/celery/vine";
        license = licenses.bsdOriginal;
        description = "Promises, promises, promises.";
      };
    };



    "webcolors" = python.mkDerivation {
      name = "webcolors-1.7";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/1c/11/d9fb5a7c872a941ad8b30a4be191253d5a9028834c4d69eab55bb6bc60be/webcolors-1.7.tar.gz"; sha256 = "e47e68644d41c0b1f1e4d939cfe4039bdf1ab31234df63c7a4f59d4766487206"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/ubernostrum/webcolors";
        license = licenses.bsdOriginal;
        description = "A library for working with color names and color value formats defined by the HTML and CSS specifications for use in documents on the Web.";
      };
    };



    "webencodings" = python.mkDerivation {
      name = "webencodings-0.5.1";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/0b/02/ae6ceac1baeda530866a85075641cec12989bd8d31af6d5ab4a3e8c92f47/webencodings-0.5.1.tar.gz"; sha256 = "b36a1c245f2d304965eb4e0a82848379241dc04b865afcc4aab16748587e1923"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/SimonSapin/python-webencodings";
        license = licenses.bsdOriginal;
        description = "Character encoding aliases for legacy web content";
      };
    };

  };
  localOverridesFile = ./requirements_override.nix;
  overrides = import localOverridesFile { inherit pkgs python; };
  commonOverrides = [

  ];
  allOverrides =
    (if (builtins.pathExists localOverridesFile)
     then [overrides] else [] ) ++ commonOverrides;

in python.withPackages
   (fix' (pkgs.lib.fold
            extends
            generated
            allOverrides
         )
   )