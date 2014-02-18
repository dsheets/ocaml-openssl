#include <openssl/ssl.h>

#define MACRO_SSL_CTX_set_options(ssl_ctx, option) SSL_CTX_set_options(ssl_ctx, option)
#undef SSL_CTX_set_options

void SSL_CTX_set_options(SSL_CTX *ssl_ctx, int option) {
  MACRO_SSL_CTX_set_options(ssl_ctx, option);
}
