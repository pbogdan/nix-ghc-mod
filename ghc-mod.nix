{ mkDerivation, base, binary, bytestring, Cabal, cabal-doctest
, cabal-helper, containers, deepseq, directory, doctest, extra
, fclabels, fetchgit, filepath, ghc, ghc-boot, ghc-mod-core
, ghc-paths, haskell-src-exts, hlint, hspec, monad-control
, monad-journal, mtl, old-time, optparse-applicative, pipes
, process, safe, semigroups, split, stdenv, syb, template-haskell
, temporary, text, time, transformers, transformers-base
}:
mkDerivation {
  pname = "ghc-mod";
  version = "5.9.0.0";
  src = fetchgit {
    url = "https://github.com/alanz/ghc-mod.git";
    sha256 = "0nl0884pg15hvbrngb6dhazmx2j3v68hgq8lh345rihj01q35mzc";
    rev = "3ccd528d4f08363ea363871fed4bb8a9a213cd2d";
    fetchSubmodules = true;
  };
  isLibrary = true;
  isExecutable = true;
  enableSeparateDataOutput = true;
  setupHaskellDepends = [ base Cabal cabal-doctest ];
  libraryHaskellDepends = [
    base binary bytestring cabal-helper containers deepseq directory
    extra fclabels filepath ghc ghc-boot ghc-mod-core ghc-paths
    haskell-src-exts hlint monad-control monad-journal mtl old-time
    optparse-applicative pipes process safe semigroups split syb
    template-haskell temporary text time transformers transformers-base
  ];
  executableHaskellDepends = [
    base binary deepseq directory fclabels filepath ghc ghc-mod-core
    monad-control mtl old-time optparse-applicative process semigroups
    split time
  ];
  testHaskellDepends = [
    base cabal-helper containers directory doctest fclabels filepath
    ghc ghc-boot ghc-mod-core hspec monad-journal mtl process split
    temporary transformers
  ];
  homepage = "https://github.com/DanielG/ghc-mod";
  description = "Happy Haskell Hacking";
  license = stdenv.lib.licenses.agpl3;
}
