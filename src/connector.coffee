class EpitechAPIConnector

	constructor: (login, password, stream) ->
		@login = login
		@password = password
		@isSignedIn = false
		{EpitechAPISettings} = require "./settings"
		@settings = new EpitechAPISettings
		@stream = stream
		request = require("request")
		@_cookieJar = request.jar()
		@request = require("request").defaults {jar: @cookieJar}

	log: (string) ->
		@stream.write "#{string}\n" if @stream

	formatRequest: (response) ->
		return JSON.parse response.body

	signIn: (callbackSuccess, callbackFailure) ->
		data =
			form:
				login: @login
				password: @password
				remind: true

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
				callbackFailure error, response if callbackFailure
			return @isSignedIn

	getModule: (year, codemodule, codeinstance, callbackSuccess, callbackFailure) ->
		url = @settings.url_module year, codemodule, codeinstance
		@log "Getting #{url}"
		@request.get url, (error, response) =>
			if !error and response.statusCode == 200
				json = @formatRequest response
				@log "Succesfully get'd #{url}"
				callbackSuccess json if callbackSuccess
			else
				@log "Failed to get #{url}"
				callbackFailure error, response if callbackFailure

	getMeetingSlots: (year, codemodule, codeinstance, codeacti, callbackSuccess, callbackFailure) ->
		url = @settings.url_activityMeetingSlots year, codemodule, codeinstance, codeacti
		@log "Getting #{url}"
		@request.get url, (error, response) =>
			if !error and response.statusCode == 200
				json = @formatRequest response
				@log "Succesfully get'd #{url}"
				callbackSuccess json if callbackSuccess
			else
				@log "Failed to get #{url}"
				callbackFailure error, response if callbackFailure

	getActivity: (year, module, city, acti, ev, callbackSuccess, callbackFailure) ->
		url = @settings.url_event year, module, city, acti, ev
		@log "Getting #{url}"
		@request.get url, (error, response) =>
			if !error and response.statusCode == 200
				json = @formatRequest response
				@log "Succesfully get'd #{url}"
				callbackSuccess json if callbackSuccess
			else
				@log "Failed to get #{url}"
				callbackFailure error, response if callbackFailure

	getActivityRegistered: (year, module, city, acti, ev, callbackSuccess, callbackFailure) ->
		url = @settings.url_eventRegistered year, module, city, acti, ev
		@log "Getting #{url}"
		@request.get url, (error, response) =>
			if !error and response.statusCode == 200
				json = @formatRequest response
				@log "Succesfully get'd #{url}"
				callbackSuccess json if callbackSuccess
			else
				@log "Failed to get #{url}"
				callbackFailure error, response if callbackFailure

	getDayActivities: (year, month, day, callbackSuccess, callbackFailure) ->
		url = @settings.url_dayActivities year, month, day
		@log "Getting #{url}"
		@request.get url, (error, response) =>
			if !error and response.statusCode == 200
				json = @formatRequest response
				@log "Succesfully get'd #{url}"
				callbackSuccess json if callbackSuccess
			else
				@log "Failed to get #{url}"
				callbackFailure error, response if callbackFailure

exports.EpitechAPIConnector = EpitechAPIConnector
