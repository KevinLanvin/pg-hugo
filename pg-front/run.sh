#!/bin/bash

rm -rf out/
mkdir -p out

set -e

curl 'http://localhost:1337/graphql' \
  -H 'Accept-Encoding: gzip, deflate, br' \
  -H 'Content-Type: application/json' \
  -H 'Accept: application/json' \
  -H 'Connection: keep-alive' \
  -H 'DNT: 1' \
  -H 'Origin: http://localhost:1337' \
  -H 'Authorization: Bearer f0e73a075ddf1c7cb3f4e01d7c82a173769ebeac7c21d4b2e3687eec383e8f9b3a7ccec24e4c1e6b1342fae207eb1d1e64d8a15e6399d3b4ef25c0f3ceabe22c145e5ad17553ca81baee86167b829728831d04596f2795d10ae37c65a024f1b0aeeba40545084b7ae183ca87394fadb07b92816a1001f153aedca98f89e1d0e2' \
  --data-raw '{"operationName":null,"variables":{},"query":"{\n  menu {\n    data {\n      attributes {\n        Logo {\n          data {\n            attributes {\n              url\n            }\n          }\n        }\n        Links {\n          label\n          href\n        }\n      }\n    }\n  }\n  contactTopBar {\n    data {\n      attributes {\n        phoneNumber\n        contactMail\n        facebook {\n          href\n        }\n        instagram {\n          href\n        }\n        linkedin {\n          href\n        }\n      }\n    }\n  }\n}\n"}' \
  --compressed > out/header.json

cat out/header.json | extract/header.js

curl 'http://localhost:1337/graphql' \
  -H 'accept: */*' \
  -H 'content-type: application/json' \
  -H 'Authorization: Bearer f0e73a075ddf1c7cb3f4e01d7c82a173769ebeac7c21d4b2e3687eec383e8f9b3a7ccec24e4c1e6b1342fae207eb1d1e64d8a15e6399d3b4ef25c0f3ceabe22c145e5ad17553ca81baee86167b829728831d04596f2795d10ae37c65a024f1b0aeeba40545084b7ae183ca87394fadb07b92816a1001f153aedca98f89e1d0e2' \
  -H 'Origin: http://localhost:1337' \
  --data-raw '{"operationName":null,"variables":{},"query":"{\n  homePage {\n    data {\n      attributes {\n        Banner {\n          data {\n            attributes {\n              url\n              alternativeText\n            }\n          }\n        }\n        MainTitle\n        sections {\n          Title\n          paragraph\n          quote\n          quoteAuthor\n          link {\n            label\n            href\n          }\n          image {\n            data {\n              attributes {\n                url\n                alternativeText\n              }\n            }\n          }\n        }\n      }\n    }\n  }\n}\n"}' \
  --compressed > out/homePage.json

  cat out/homePage.json | extract/homePage.js