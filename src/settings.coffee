class EpitechAPISettings

	url_signIn: ->
		return "https://intra.epitech.eu/?format=json"

	url_module: (year, code, suffix) ->
		return "https://intra.epitech.eu/module/#{year}/#{code}/#{suffix}/?format=json"

	url_activityMeetingSlots: (year, code, suffix, codeacti) ->
		return "https://intra.epitech.eu/module/#{year}/#{code}/#{suffix}/#{codeacti}/rdv/?format=json"


exports.EpitechAPISettings = EpitechAPISettings