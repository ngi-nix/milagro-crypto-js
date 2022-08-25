inputs: versions: _: final: rec {
  maintainers.svaes = {
    email = "sil.g.vaes@gmail.com";
    matrix = "@egyptian_cowboy:matrix";
    name = "Sil Vaes";
    github = "s-vaes";
    githubId = 8971074;
  };
  
  nodePackages = {
    milagro-crypto-js = (final.callPackage ./milagro-crypto-js { }).overrideAttrs (oldAttrs: {
      src = inputs.milagro-crypto-js;
      version = versions.milagro-crypto-js;
    });
  };

  # default = dta.dta;

  # devShells.default = final.callPackage ./shell.nix { };
}
