# AI-generated with Claude Code (Claude Opus 5.5)
# Fix build with OpenSSL 4, only applied when OpenSSL 4 is selected, see README.md
# https://git.openembedded.org/openembedded-core/commit/?id=495802fa6ffb0c455e72abfce358fb2ced27c779
FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
SRC_URI:append = "${@' file://0001-lib-iolog-use-accessor-for-ASN1_STRING-length.patch' if (d.getVar('PREFERRED_VERSION_openssl') or '').startswith('4') else ''}"
