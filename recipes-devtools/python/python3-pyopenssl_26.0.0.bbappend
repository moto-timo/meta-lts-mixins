# AI-generated with Claude Code (Claude Opus 5.5)
# Fix master_key() for TLS 1.3 with OpenSSL 4.1, only applied when OpenSSL 4 is selected, see README.md
# https://git.openembedded.org/openembedded-core/commit/?id=1dfcf41f3bc56c140557fcdd4ae3b1692a5596c2
FILESEXTRAPATHS:prepend := "${THISDIR}/python3-pyopenssl:"
SRC_URI:append = "${@' file://0001-Return-None-from-master_key-for-TLS-1.3-connections.patch' if (d.getVar('PREFERRED_VERSION_openssl') or '').startswith('4') else ''}"
