# This file was auto-generated by cabal2nix. Please do NOT edit manually!

{ cabal, bindingsDSL, git, openssl, zlib }:

cabal.mkDerivation (self: {
  pname = "hlibgit2";
  version = "0.18.0.13";
  sha256 = "1bslg51kkhnwm48kxaad4izq3xmzv6dpqy10a5kh16vr5zy3w5hz";
  buildDepends = [ bindingsDSL zlib ];
  testDepends = [ git ];
  extraLibraries = [ openssl ];
  meta = {
    description = "Low-level bindings to libgit2";
    license = self.stdenv.lib.licenses.mit;
    platforms = self.ghc.meta.platforms;
    maintainers = with self.stdenv.lib.maintainers; [ ianwookim ];
  };
})
