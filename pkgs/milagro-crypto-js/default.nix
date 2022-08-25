{ lib, stdenv, mkYarnPackage, fetchFromGitHub, nodejs, ... }:

mkYarnPackage {
  pname = "milagro-crypto-js";
  version = "1.0.0";
  # Download source code from GitHub
  src = fetchFromGitHub ({
    owner = "apache";
    repo = "incubator-milagro-crypto-js";
    # Commit or tag, note that fetchFromGitHub cannot follow a branch!
    rev = "1.0.0";
    # Download git submodules, most packages don't need this
    fetchSubmodules = false;
    # Don't know how to calculate the SHA256 here? Comment it out and build the package
    # Nix will raise an error and show the correct hash
    sha256 = "1cw86vnx7r1q8zcxl6y0m2smmydg0zmi5fyky5bzc01wvn7pj49k";
  });

  packageJSON = ./package.json;
  yarnLock = ./yarn.lock;
  yarnNix = ./yarn.nix;
  buildInputs = [ nodejs ];
}
