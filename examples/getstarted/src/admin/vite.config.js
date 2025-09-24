const { mergeConfig } = require('vite');

module.exports = (config) => {
  return mergeConfig(config, {
    server: {
      allowedHosts: [
        'localhost',
        '127.0.0.1',
        'strapi.dev.tipsoption.com',
        '.tipsoption.com'
      ],
      host: '0.0.0.0'
    }
  });
};