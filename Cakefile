fs = require 'fs'

{print} = require 'sys'
{spawn} = require 'child_process'

build = (callback) ->
	coffee = spawn 'coffee', ['-c', 'src']
	coffee.stderr.on 'data', (data) ->
		process.stderr.write data.toString()
	coffee.stdout.on 'data', (data) ->
		print data.toString()
	coffee.on 'exit', (code) ->
		callback?() if code is 0

task 'build', 'Build from src/', ->
  	build()
task 'sbuild', "Build from src/", ->
	build()