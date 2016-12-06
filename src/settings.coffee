class EpitechAPISettings

	url_signIn: ->
		return "https://intra.epitech.eu/?format=json"

	url_module: (year, codemodule, codeinstance) ->
		return "https://intra.epitech.eu/module/#{year}/#{codemodule}/#{codeinstance}/?format=json"

	url_activityMeetingSlots: (year, codemodule, codeinstance, codeacti) ->
		return "https://intra.epitech.eu/module/#{year}/#{codemodule}/#{codeinstance}/#{codeacti}/rdv/?format=json"
	
	url_event: (year, module, city, acti, ev) ->
		return "https://intra.epitech.eu/module/#{year}/#{module}/#{city}/acti-#{acti}/event-#{ev}?format=json"

	url_eventRegistered: (year, module, city, acti, ev) ->
		return "https://intra.epitech.eu/module/#{year}/#{module}/#{city}/acti-#{acti}/event-#{ev}/registered?format=json"
	
exports.EpitechAPISettings = EpitechAPISettings
