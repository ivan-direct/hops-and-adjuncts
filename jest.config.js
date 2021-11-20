module.exports = {

  coverageDirectory: "coverage",

  moduleFileExtensions: [
   "ts",
   "tsx",
   "js"
  ],

  testEnvironment: "jsdom",

  moduleNameMapper: {
    "\\.(css|scss)$": "identity-obj-proxy"
  },

  testRegex: "__tests__\/.*\.test\.js$",

};