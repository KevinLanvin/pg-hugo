module.exports = ({ env }) => ({
  auth: {
    secret: env('ADMIN_JWT_SECRET', '40f331a38b5d718c1999b7ace0d6423f'),
  },
});
