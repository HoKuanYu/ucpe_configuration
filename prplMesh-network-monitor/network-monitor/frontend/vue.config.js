// const path = require("path");
// const apiMocker = require("mocker-api");

module.exports = {
  chainWebpack: config => {
    config.module.rules.delete("eslint");
  }
  // devServer: {
  //   before(app) {
  //     apiMocker(app, path.resolve("./mocker/index.js"));
  //   }
  // }
};
