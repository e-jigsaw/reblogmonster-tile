# grut config
module.exports = (grunt)->
	grunt.initConfig
		pkg: "<json:package.json>"
		coffee:
			self:
				src: ["grunt.coffee"]
				dest: "./"
				options:
					bare: true
			app:
				src: ["app.coffee"]
				dest: "./"
				options:
					bare: true
			routes:
				src: ["routes/*.coffee"]
				dest: "routes/"
				options:
					bare: true

		watch:
			files: ["grunt.coffee", "*.coffee", "routes/*.coffee"]
			tasks: "coffee"

		grunt.loadNpmTasks "grunt-coffee"

		grunt.registerTask "default", "watch"