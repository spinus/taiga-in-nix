{ pkgs, python }:

self: super: {
    # adding missing, implicit dependency :/ why people do that?
    "sampledata" = super.sampledata.overrideAttrs (old: {
        propagatedBuildInputs = old.propagatedBuildInputs ++ [
          super."versiontools"
        ];
    });
    "asana" = super.asana.overrideAttrs (old: {
        propagatedBuildInputs = old.propagatedBuildInputs ++ [
          super."requests-oauthlib"
        ];
    });
    lxml = super.lxml.overrideAttrs (old: {
      # For html5lib requires lxml, lxml requires html5lib :/ let's try to break the cycle here by removing html5lib from lxml
      propagatedBuildInputs = pkgs.stdenv.lib.filter
          (x: ! pkgs.lib.strings.hasPrefix "python3.6-html5lib" x.name)
          old.propagatedBuildInputs;
    });

}
