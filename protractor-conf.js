exports.config = {

  specs: [
    'features/**/*.feature'
  ],

  capabilities: {
    'browserName': 'chrome'
  },

  baseUrl: 'http://127.0.0.1:8000/',

    framework: 'custom',
    frameworkPath: require.resolve('protractor-cucumber-framework'),
  // relevant cucumber command line options
  cucumberOpts: {
    require: ['features/support/world.js', 'features/sampleSteps.js'],
    format: "summary"
  }
};
