self: super: {
  haskellPackages = super.haskellPackages.override (
    old: {
      overrides = self.lib.composeExtensions (old.overrides or (_:_: {})) (
        hself: hsuper: with self.haskell.lib; {
          cabal-helper-lib = doJailbreak (hself.callPackage ./cabal-helper.nix {});
          cabal-helper-bin = justStaticExecutables hself.cabal-helper-lib;
          ghc-mod-raw = hself.callPackage ./ghc-mod.nix {
            ghc-mod-core = null;
            cabal-helper = hself.cabal-helper-lib;
          };
          ghc-mod-core = doJailbreak (
            overrideCabal hself.ghc-mod-raw (
              drv: {
                pname = "ghc-mod-core";
                postUnpack = "sourceRoot=$(echo */core)";
              }
            )
          );
          ghc-mod =
            overrideCabal (
              justStaticExecutables (
                dontCheck (
                  doJailbreak (hself.ghc-mod-raw.override { inherit (hself) ghc-mod-core; })
                )
              )
            )
              (
                drv: {
                  executableHaskellDepends = drv.executableHaskellDepends or []
                  ++ [ self.makeWrapper self.removeReferencesTo ];
                  postInstall = drv.postInstall or "" + ''
                    remove-references-to -t ${hself.ghc} $out/bin/ghc-mod
                    remove-references-to -t ${hself.ghc-mod-core} $out/bin/ghc-mod
                    remove-references-to -t ${hself.cabal-helper-lib} $out/bin/ghc-mod
                    wrapProgram "$out/bin/ghc-mod" \
                    --set cabal_helper_libexecdir \
                    ${hself.cabal-helper-bin}/bin
                  '';
                }
              );
        }
      );
    }
  );

  inherit (self.haskellPackages) ghc-mod;
}
