module Test.Fixtures.Manifest where

import Registry.Prelude
import Foreign.Object as Object
import Foreign.SPDX as SPDX
import Foreign.SemVer as SemVer
import Partial.Unsafe as Partial.Unsafe
import Registry.PackageName (PackageName)
import Registry.PackageName as PackageName
import Registry.Schema (Manifest)
import Registry.Schema as Schema

ab ::
  { name :: PackageName
  , v1a :: Manifest
  , v1b :: Manifest
  , v2 :: Manifest
  }
ab = { name, v1a, v1b, v2 }
  where
  name = unsafeFromJust $ hush $ PackageName.parse "ab"
  version1 = unsafeFromJust $ SemVer.parseSemVer "1.0.0"
  targets = Object.singleton "lib"
    { dependencies: Object.empty
    , sources: [ "src/**/*.purs" ]
    }
  version2 = unsafeFromJust $ SemVer.parseSemVer "2.0.0"
  license = unsafeFromJust $ hush $ SPDX.parse "MIT"
  repositoryWrong = Schema.GitHub
    { owner: "ab-wrong-user"
    , repo: "ab"
    , subdir: Nothing
    }
  repository = Schema.GitHub
    { owner: "abc-user"
    , repo: "abc"
    , subdir: Nothing
    }
  v1a = { name, version: version1, license, repository: repositoryWrong, targets }
  v1b = { name, version: version1, license, repository, targets }
  v2 = { name, version: version2, license, repository, targets }

abc :: { name :: PackageName, v1 :: Manifest, v2 :: Manifest }
abc = { name, v1, v2 }
  where
  name = unsafeFromJust $ hush $ PackageName.parse "abc"
  version1 = unsafeFromJust $ SemVer.parseSemVer "1.0.0"
  targets1 = Object.singleton "lib"
    { dependencies: Object.singleton "ab" (unsafeFromJust (SemVer.parseRange "^1.0.0"))
    , sources: [ "src/**/*.purs" ]
    }
  version2 = unsafeFromJust $ SemVer.parseSemVer "2.0.0"
  targets2 = Object.singleton "lib"
    { dependencies: Object.singleton "ab" (unsafeFromJust (SemVer.parseRange "^2.0.0"))
    , sources: [ "src/**/*.purs" ]
    }
  license = unsafeFromJust $ hush $ SPDX.parse "MIT"
  repository = Schema.GitHub
    { owner: "abc-user"
    , repo: "abc"
    , subdir: Nothing
    }
  v1 = { name, version: version1, license, repository, targets: targets1 }
  v2 = { name, version: version2, license, repository, targets: targets2 }

abcd :: { name :: PackageName, v1 :: Manifest, v2 :: Manifest }
abcd = { name, v1, v2 }
  where
  name = unsafeFromJust $ hush $ PackageName.parse "abcd"
  version1 = unsafeFromJust $ SemVer.parseSemVer "1.0.0"
  targets1 = Object.singleton "lib"
    { dependencies: Object.singleton "abc" (unsafeFromJust (SemVer.parseRange "^1.0.0"))
    , sources: [ "src/**/*.purs" ]
    }
  version2 = unsafeFromJust $ SemVer.parseSemVer "2.0.0"
  targets2 = Object.singleton "lib"
    { dependencies: Object.singleton "abc" (unsafeFromJust (SemVer.parseRange "^2.0.0"))
    , sources: [ "src/**/*.purs" ]
    }
  license = unsafeFromJust $ hush $ SPDX.parse "MIT"
  repository = Schema.GitHub
    { owner: "abcd-user"
    , repo: "abcd"
    , subdir: Nothing
    }
  v1 = { name, version: version1, license, repository, targets: targets1 }
  v2 = { name, version: version2, license, repository, targets: targets2 }

unsafeFromJust :: forall a. Maybe a -> a
unsafeFromJust = Partial.Unsafe.unsafePartial fromJust
