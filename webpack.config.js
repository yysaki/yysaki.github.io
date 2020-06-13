const path = require('path');

const isDevelopment = process.env.NODE_ENV !== 'production';

module.exports = {
  mode: 'production',
  entry: './src/index.js',
  output: {
    path: path.resolve(__dirname, 'output'),
    filename: 'main.js'
  },
  module: {
    rules: [
      {
        test: /\.s[ac]ss$/i,
        use: [
          'style-loader',
          {
            loader: 'css-loader',
            options: {
              sourceMap: isDevelopment,
            }
          },
          {
            loader: 'sass-loader',
            options: {
              sourceMap: isDevelopment,
            }
          }
        ]
      }
    ]
  }
}
