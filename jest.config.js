module.exports = {

  coverageDirectory: "coverage",

  moduleFileExtensions: [
   "ts",
   "tsx",
   "js"
  ],

  testEnvironment: "jsdom",

  moduleNameMapper: {
    moduleFileExtensions: ["js", "jsx"],
    moduleDirectories: ["node_modules", "bower_components", "shared"],
    "\\.(jpg|jpeg|png|gif|eot|otf|webp|svg|ttf|woff|woff2|mp4|webm|wav|mp3|m4a|aac|oga)$": "<rootDir>/__mocks__/fileMock.js",
    "\\.(css|less)$": "<rootDir>/__mocks__/styleMock.js",
  },

  testRegex: "__tests__\/.*\.test\.js$",

};