define
	class RequireComponent
		load: (name, req, load, config) ->
			{component, module} = name.split('#')
			console.log "Name: ", name
			console.log "PARSED NAME - component:", component, "module:", module
			console.log "Config:", config
			nothingYet = {}
			load(nothingYet)

		normalize: (name, normalize) ->
			normalize(name)

		write: (pluginName, moduleName, write) ->
			console.log "Write:", pluginName, moduleName, write

		