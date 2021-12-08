const { merge } = require('webpack-merge');
const { webpackConfig } = require("@rails/webpacker");

loaderConfig = {
  entry: "./app/javascript/packs/application.js",
  module: {
    rules: [
      {
        test: /\.(js|jsx)$/,
        exclude: /node_modules/,
        use: {
          loader: "babel-loader",
        },
      },
      {
        test: /\.css$/i,
        use: ["style-loader", "css-loader", "postcss-loader"],
      },
      {
        test: /\.less$/i,
        use: ["style-loader", "less-loader"],
      },
    ],
  },
};

console.log(webpackConfig);

module.exports = merge(loaderConfig, webpackConfig);
