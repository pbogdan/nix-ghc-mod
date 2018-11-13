self: super: {
  ghc-mod =
    with super.haskell.lib;
    let hp = super.haskellPackages;
        cabal-helper-lib = doJailbreak (hp.callPackage ./cabal-helper.nix {});
        cabal-helper-bin = justStaticExecutables cabal-helper-lib;
        ghc-mod-raw  = hp.callPackage ./ghc-mod.nix {
          ghc-mod-core = null;
          cabal-helper = cabal-helper-lib;
        };
        ghc-mod-core = doJailbreak (overrideCabal ghc-mod-raw (drv: {
          pname = "ghc-mod-core";
          postUnpack = "sourceRoot=$(echo */core)";
        }));
        in
          overrideCabal(
          justStaticExecutables(
          dontCheck(
          doJailbreak (ghc-mod-raw.override { inherit ghc-mod-core; }))))
          (drv: {
             executableHaskellDepends = drv.executableHaskellDepends or []
              ++ [ pkgs.makeWrapper pkgs.removeReferencesTo ];
            postInstall = drv.postInstall or "" + ''
              remove-references-to -t ${hp.ghc} $out/bin/ghc-mod
              remove-references-to -t ${ghc-mod-core} $out/bin/ghc-mod
              remove-references-to -t ${cabal-helper-lib} $out/bin/ghc-mod
              wrapProgram "$out/bin/ghc-mod" \
                --set cabal_helper_libexecdir \
                  $(dirname $(find ${cabal-helper-bin}/libexec -name cabal-helper-wrapper))
            '';
          });
}
