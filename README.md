meta-lts-mixins - wrynose/openssl
=================================

"Mixin" layer for adding a newer OpenSSL into the Yocto Project LTS.

At the time Wrynose was released in May 2026 it included OpenSSL 3.5.x (an
upstream LTS series), and officially Wrynose supports only that. This thin
special-purpose mixin layer is meant to provide OpenSSL 4.1 for Wrynose by
backporting the openssl recipe from the master branch of openembedded-core.

OpenSSL 4 is a major release with API and ABI changes (for example, the
ENGINE API has been removed, and with it the openssl-engines package and the
cryptodev-linux PACKAGECONFIG). Other recipes in Wrynose, or in other layers,
may need fixes to build against it.

In order to make this layer Yocto Project Compatible, the layer should not
provide new versions of packages by default. Because of this, the recipe
provided in this layer will not be used unless that is explicitly stated. To
use the provided openssl recipe, add the following to local.conf or a distro
configuration:

```
PREFERRED_VERSION_openssl = "4.1.%"
PREFERRED_VERSION_openssl-native = "4.1.%"
PREFERRED_VERSION_nativesdk-openssl = "4.1.%"
```

The layer also carries bbappends with fixes backported from openembedded-core
master for recipes that need changes to work with OpenSSL 4:

- sudo
- python3-cryptography
- python3-pyopenssl

These fixes are only applied when `PREFERRED_VERSION_openssl` starts with
"4", so set it as shown above rather than overriding `DEFAULT_PREFERENCE`.

Dependencies
------------

This layer depends on:

- URI: git://github.com/openembedded/openembedded-core.git
  layers: meta
  branch: wrynose

This layer recommends:

- URI: https://git.yoctoproject.org/meta-lts-mixins
  layers: wrynose-rust-mixin
  branch: wrynose/rust

The Rust crate openssl-sys refuses to build against OpenSSL 4 before version
0.9.114, and the Rust recipes in wrynose vendor older versions. Without
wrynose/rust, cargo, and every Rust recipe built with cargo-native, fail when
`PREFERRED_VERSION_openssl-native` selects OpenSSL 4. wrynose/rust provides
cargo and cargo-c that vendor openssl-sys 0.9.117, but the following recipes
still vendor an older openssl-sys and fail against OpenSSL 4 even with it:

- python3-cryptography (openssl-sys 0.9.110)
- rpm-sequoia (openssl-sys 0.9.111)
- python3-maturin (openssl-sys 0.9.111), if it builds openssl-sys

Keeping `PREFERRED_VERSION_openssl-native` at the wrynose default avoids the
problem for native recipes, but not for target ones.

Contributing
------------

The patches can be backported from openembedded-core with:

    git -C ../openembedded-core format-patch --stdout -1 origin/master meta/recipes-connectivity/openssl | \
      git am --signoff -p4 --directory=recipes-connectivity/openssl

The yocto-patches mailinglist (yocto-patches@lists.yoctoproject.org) is used
for questions, comments and patch review. It is subscriber only, so please
register before posting.

Send pull requests to yocto-patches@lists.yoctoproject.org with
'[meta-lts-mixins][wrynose/openssl]' in the subject.

When sending single patches, please use something like:

    git send-email -M -1 --to=yocto-patches@lists.yoctoproject.org --subject-prefix='meta-lts-mixins][wrynose/openssl][PATCH'

Maintenance
-----------

Layer maintainers:
* Tim Orling <tim.orling@konsulko.com>
