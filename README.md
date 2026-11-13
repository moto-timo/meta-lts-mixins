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
use the provided openssl recipe, the following can be done:

```
# please use 'DEFAULT_PREFERENCE:your_override = ""' to keep Yocto Project Compatible
echo 'DEFAULT_PREFERENCE = ""' >> recipes-connectivity/openssl/openssl_%.bbappend
```

Alternatively, in local.conf or a distro configuration:

```
PREFERRED_VERSION_openssl = "4.1.%"
PREFERRED_VERSION_openssl-native = "4.1.%"
PREFERRED_VERSION_nativesdk-openssl = "4.1.%"
```

Dependencies
------------

This layer depends on:

- URI: git://github.com/openembedded/openembedded-core.git
  layers: meta
  branch: wrynose

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
