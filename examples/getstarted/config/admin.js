module.exports = ({ env }) => ({
  url: env('ADMIN_PATH', '/admin'),
  serveAdminPanel: env.bool('SERVE_ADMIN', true),
  // autoOpen: false,
  vite: {
    server: {
      host: true, // Permitir acceso externo
      origin: 'auto' // Detectar origen automáticamente
    }
  },
  auth: {
    secret: env('ADMIN_JWT_SECRET', 'example-token'),
  },
  apiToken: {
    salt: env('API_TOKEN_SALT', 'example-salt'),
  },
  auditLogs: {
    enabled: env.bool('AUDIT_LOGS_ENABLED', true),
  },
  transfer: {
    token: {
      salt: env('TRANSFER_TOKEN_SALT', 'example-salt'),
    },
  },
  secrets: {
    encryptionKey: env('ENCRYPTION_KEY', 'example-key'),
  },
  flags: {
    nps: env.bool('FLAG_NPS', true),
    promoteEE: env.bool('FLAG_PROMOTE_EE', true),
  },
  preview: {
    enabled: env.bool('PREVIEW_ENABLED', true),
    config: {
      handler: (uid, { documentId, locale, status }) => {
        const kind =
          strapi.contentType(uid).kind === 'collectionType' ? 'collection-types' : 'single-types';
        return `/admin/preview/${kind}/${uid}/${documentId}/${locale}/${status}`;
      },
    },
  },
});
