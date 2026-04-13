module.exports = {
  dependency: {
    platforms: {
      android: {
        sourceDir: './react-native/android',
        packageImportPath: 'import ai.besitos.offerwall.rn.OfferwallPackage;',
        packageInstance: 'new OfferwallPackage()',
      },
      ios: {
        podspecPath: './react-native/BesitosOfferwallRN.podspec',
      },
    },
  },
};
