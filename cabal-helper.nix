{ mkDerivation, base, bytestring, Cabal, cabal-install, cabal-plan
, containers, directory, fetchFromGitHub, filepath, ghc, ghc-paths, mtl
, pretty-show, process, semigroupoids, stdenv, template-haskell
, temporary, text, transformers, unix, unix-compat, utf8-string
}:
mkDerivation {
  pname = "cabal-helper";
  version = "1.0.0.0";
  src = fetchFromGitHub {
    owner = "alanz";
    repo = "cabal-helper";
    sha256 = "1lypls1zkyg7pq2xcg6mm25x7rgndy2553yakdkayg4m8msr7f8f";
    rev = "8fecf6a7754424ed1653dce632382707e8f03499";
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
