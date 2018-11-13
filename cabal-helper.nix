{ mkDerivation, base, bytestring, Cabal, cabal-install, cabal-plan
, containers, directory, fetchgit, filepath, ghc, ghc-paths, mtl
, pretty-show, process, semigroupoids, stdenv, template-haskell
, temporary, text, transformers, unix, unix-compat, utf8-string
}:
mkDerivation {
  pname = "cabal-helper";
  version = "1.0.0.0";
  src = fetchgit {
    url = "git@github.com:alanz/cabal-helper.git";
    sha256 = "1sxanylvny5mggny1w296cci1vs5g45byl9z5b6rawxqjn9clwih";
    rev = "9142d8a9e6ed18faf17a360521fbbbd25f6a3b47";
    fetchSubmodules = true;
  };
  isLibrary = true;
  isExecutable = true;
  libraryHaskellDepends = [
    base Cabal cabal-plan containers directory filepath mtl process
    semigroupoids transformers unix unix-compat
  ];
  executableHaskellDepends = [
    base bytestring Cabal cabal-plan containers directory filepath mtl
    pretty-show process template-haskell temporary text transformers
    unix unix-compat utf8-string
  ];
  executableToolDepends = [ cabal-install ];
  testHaskellDepends = [
    base bytestring Cabal cabal-plan containers directory filepath ghc
    ghc-paths mtl pretty-show process template-haskell temporary text
    transformers unix unix-compat utf8-string
  ];
  testToolDepends = [ cabal-install ];
  doCheck = false;
  description = "Simple interface to some of Cabal's configuration state, mainly used by ghc-mod";
  license = stdenv.lib.licenses.agpl3;
}
