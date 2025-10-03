module.exports = {
  entry: "./app.jsx",
  output: {
    filename: "./public/js/app/bundle.js",
  },
  devServer: {
    port: 9900,
    open: true,
    openPage: "public/index.html"
  },
  resolve: {
    extensions: [".webpack.js", ".web.js", ".ts", ".vue", ".js", ".jsx"]
  },
  mode: "production",
  module: {
    rules: [
      {
        test: /\.jsx?$/,
        exclude: /node_modules\/(?!devextreme)/,
        use: {
          loader: 'babel-loader',
          options: {
            presets: [
              ['@babel/preset-env', {
                targets: {
                  browsers: ['last 2 versions', 'ie >= 11']
                }
              }],
              '@babel/preset-react'
            ]
          }
        }
      },
      {
        test: /\.css$/,
        use: [
          { loader: "style-loader" },
          { loader: "css-loader" }
        ]
      },
      { 
        test: /\.(eot|svg|ttf|woff|woff2)$/, 
        use: "url-loader?name=[name].[ext]"
      }
    ]
  },
  performance: {
    hints: false,
    maxEntrypointSize: 2000000,
    maxAssetSize: 2000000
  }
};