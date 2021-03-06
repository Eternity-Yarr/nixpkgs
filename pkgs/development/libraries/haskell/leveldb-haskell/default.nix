# This file was auto-generated by cabal2nix. Please do NOT edit manually!

{ cabal, async, dataDefault, filepath, leveldb, resourcet, snappy
, transformers
}:

cabal.mkDerivation (self: {
  pname = "leveldb-haskell";
  version = "0.3.1";
  sha256 = "09pyji49sdl60xicd32ra7v72qf0jkjhnvpsfr9k698is7lcq06d";
  isLibrary = true;
  isExecutable = true;
  buildDepends = [
    async dataDefault filepath resourcet transformers
  ];
  extraLibraries = [ leveldb snappy ];
  meta = {
    homepage = "http://github.com/kim/leveldb-haskell";
    description = "Haskell bindings to LevelDB";
    license = self.stdenv.lib.licenses.bsd3;
    platforms = self.ghc.meta.platforms;
  };
})
