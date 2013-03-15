exec = require('child_process').exec
fs = require 'fs'
path = require 'path'

input =
	spec: path.join 'spec'
	src: path.join 'src'

output =
	spec: path.join 'test', 'spec'
	src: path.join 'test', 'src'

rmrf = (dir, callback) ->
	fs.stat dir, (err, stats) ->
		return callback err if err
		return fs.unlink dir, callback if not stats.isDirectory()

		count = 0
		fs.readdir dir, (err, files) ->
			return callback err if err
			return fs.rmdir dir, callback if files.length < 1

			files.forEach (file) ->
				sub = path.join dir, file
				rmrf sub, (err) ->
					return callback err if err
					fs.rmdir dir, callback if ++count is files.length

forOf = (object, callback, cont) ->
	for prop, value of object
		callback prop, value
	cont?()

rjs = (options, cont) ->
	console.log "Optimizing with r.js"

option '-r', '--rjs', 'r.js optimize'

task 'build', (options) ->
	forOf output, (_, value) ->
		rmrf value, (err) ->
			if err?
				console.error "Clean up error: ", err
				process.exit 1
	, () ->
		console.log "Cleaned up"
		console.log "Compiling..."
		forOf input, (prop, value) ->
			exec "coffee -c -b -o #{output[prop]} #{value}", (err, stdout, stderr) ->
				console.log "stdout: #{stdout}" if stdout
				console.error "stderr: #{stderr}" if stderr
				console.error "error thrown ", err if err?
		, () ->
			if options.rjs
				rjs options, () ->
					console.log "Done"
			else
				console.log "Done"
