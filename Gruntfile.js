module.exports = function(grunt) {
  grunt.initConfig({
    // running `grunt less` will compile once
    less: {
      development: {
        options: {
          paths: ["./css"],
          yuicompress: true
        },
      files: {
        "./public/app.css": "./less/app.less"
      }
    }
  },
  // running `grunt watch` will watch for changes
  watch: {
    files: "./less/*.less",
    tasks: ["less"]
  }
});
  grunt.loadNpmTasks('grunt-contrib-less');
  grunt.loadNpmTasks('grunt-contrib-watch');
};
