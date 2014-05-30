module.exports = (grunt) ->
  # Project configuration.
  grunt.initConfig
    pkg: grunt.file.readJSON "package.json"

    modernizr:
      dist:
        # [REQUIRED] Path to the build you're using for development.
        devFile: "<%= pkg.vendor_path %>/js/modernizr-dev.js"
        # [REQUIRED] Path to save out the built file.
        outputFile: "<%= pkg.vendor_path %>/js/modernizr-custom.js"
        # Based on default settings on http://modernizr.com/download/
        extra:
          shiv:       false
          printshiv:  false
          load:       true
          mq:         true
          cssclasses: true
        # Based on default settings on http://modernizr.com/download/
        extensibility:
          addtest:      false  
          prefixed:     false
          teststyles:   false  
          testprops:    false
          testallprops: false
          hasevents:    false
          prefixes:     false
          domprefixes:  false
        # By default, source is uglified before saving
        uglify: false
        # Define any tests you want to implicitly include.
        tests: []
        # By default, this task will crawl your project for references to Modernizr tests.
        # Set to false to disable.
        parseFiles: true
        # When parseFiles = true, this task will crawl all *.js, *.css, *.scss files, except files that are in node_modules/.
        # You can override this by defining a "files" array below.
        files: 
          src: [
            "<%= pkg.build_path %>/css/*.css"
            "<%= pkg.js_path %>/*.js"
          ]
        # When parseFiles = true, matchCommunityTests = true will attempt to
        # match user-contributed tests.
        matchCommunityTests: false
        # Have custom Modernizr tests? Add paths to their location here.
        customTests: []
        # Files added here will be excluded when looking for Modernizr refs. The object supports all minimatch options.
        # excludeFiles:
    
    imagemin:
      build:
        files: [
          expand: true
          cwd: "<%= pkg.build_path %>/img/"
          src: ["*.{png,jpg,gif}"]
          dest:"<%= pkg.build_path %>/img/"
        ]
      source:
        files: [
          expand: true
          cwd: "<%= pkg.image_path %>/"
          src: ["*.{png,jpg,gif}"]
          dest:"<%= pkg.image_path %>/"
        ]

    svgmin:
      dist:
        files: [
          expand: true
          cwd:    "<%= pkg.image_path %>/"
          src:    ["*.svg"]
          dest:   "<%= pkg.image_path %>/"
        ]
      inline:
        files: [
          expand: true
          cwd:    "<%= pkg.vendor_path %>/svg/"
          src:    ["*.svg"]
          dest:   "<%= pkg.source_path %>/partial/svg/"
          ext:    ".erb"
          rename: (dest, src) ->
            "#{dest}_#{src.split('<%= pkg.name %>_')[1]}" 
        ]

    clean:
      build_trash:
        src: [
          "<%= pkg.build_path %>/crossdomain.xml"
          "<%= pkg.build_path %>/LICENSE"
          "<%= pkg.build_path %>/README"
          # "<%= pkg.build_path %>/css/*"
          "<%= pkg.build_path %>/js/**"
          # 要保留的檔案寫在底下
          "!<%= pkg.build_path %>/css/fonts"
          # "!<%= pkg.build_path %>/css/main-*.css"
          "!<%= pkg.build_path %>/js/ie-*.js"
          "!<%= pkg.build_path %>/js/main-*.js"
        ]

    compass:
      dist:
        options:
          config:         "config/compass.rb"
          bundleExec:     true    

    watch:
      sass:
        files: [
          "<%= pkg.sass_path %>/**/*.scss"
        ]
        tasks: ["compass:dist"]
        options:
          spawn: false
      refresh:
        files: [
          "source/*.slim"
          "source/partial/**"
          "source/layout/**"
          "data/**"
          "source/js/**"
        ]
        options:
          spawn: false
          livereload: true
          interval: 1200
      livereload:
        files: [
          "<%= pkg.css_path %>/*.css"
        ]
        options:
          livereload: true

  # load all grunt tasks matching the `grunt-*` pattern
  require('load-grunt-tasks')(grunt)

  # Default task(s).
  grunt.registerTask "default", ["compass", "watch"]
  grunt.registerTask "middleman", ["clean:build_trash"]