# AI-generated with Claude Code (Claude Opus 5.5)
# Fix AEAD bad-tag handling with OpenSSL 4.1, only applied when OpenSSL 4 is selected, see README.md
# https://git.openembedded.org/openembedded-core/commit/?id=e43cacf722486762b2a83198aeb32c36a27f4eb7
FILESEXTRAPATHS:prepend := "${THISDIR}/python3-cryptography:"
SRC_URI:append = "${@' file://0001-Raise-InvalidTag-on-AEAD-finalize-failure-regardless.patch' if (d.getVar('PREFERRED_VERSION_openssl') or '').startswith('4') else ''}"
