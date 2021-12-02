module.exports = {
  root: true,
  env: {
    browser: true,
    es2021: true,
  },
  extends: ["plugin:react/recommended", "airbnb"],
  parserOptions: {
    ecmaFeatures: {
      jsx: true,
    },
    ecmaVersion: 13,
    sourceType: "module",
  },
  plugins: ["react"],
  rules: {
    "react/jsx-wrap-multilines": 0,
    "react/jsx-filename-extension": [1, { extensions: [".js", ".jsx"] }],
    "operator-linebreak": ["error", "after"],
    quotes: ["error", "double"],
    "object-curly-newline": 0,
  },
};
