class EpitechAPIConnector

	constructor: (login, password, stream) ->
		@login = login
		@password = password
		@isSignedIn = false
		{EpitechAPISettings} = require "./settings"
		@settings = new EpitechAPISettings
		@stream = stream

		@request = require("request").defaults {jar: true}

	log: (string) ->
		@stream.write "#{string}\n" if @stream

	formatRequest: (response) ->
		return JSON.parse response.body.substr response.body.indexOf '\n'

	signIn: (callbackSuccess, callbackFailure) ->
		data =
			form:
				login: @login
				password: @password
				remind: true
		tried = false

		url = do @settings.url_signIn
		@log "Getting #{url}"
		return @request.post url, data, (error, response) =>
			if !error and response.statusCode == 200
				@isSignedIn = true
				json = @formatRequest response
				@log "Student has been logged in"
				callbackSuccess json if callbackSuccess
			else
				@log "Student cannot be logged in"
				callbackFailure error response if callbackFailure
			return @isSignedIn

	getModule: (year, code, suffix, callbackSuccess, callbackFailure) ->
		url = @settings.url_module year, code, suffix
		@log "Getting #{url}"
		@request.get url, (error, response) =>
			if !error and response.statusCode == 200
				json = @formatRequest response
				@log "Succesfully get'd #{url}"
				callbackSuccess json if callbackSuccess
			else
				@log "Failed to get #{url}"
				callbackFailure error response if callbackFailure

	getMeetingSlots: (year, code, suffix, codeacti, callbackSuccess, callbackFailure) ->
		url = @settings.url_activityMeetingSlots year, code, suffix, codeacti
		@log "Getting #{url}"
		@request.get url, (error, response) =>
			if !error and response.statusCode == 200
				json = @formatRequest response
				@log "Succesfully get'd #{url}"
				callbackSuccess json if callbackSuccess
			else
				@log "Failed to get #{url}"
				callbackFailure error response if callbackFailure

exports.EpitechAPIConnector = EpitechAPIConnector