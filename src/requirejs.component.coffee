# Copyright (c) 2012. Mikkel Schmidt (Secoya A/S).
# Version 0.0.1

define [], () ->
	class RequireComponent
		load: (name, req, load, config) ->
			[component, module] = name.split('#')

			if config.component?.path?
				componentpath = config.component.path + '/' + component
			if config.component?.paths?[component]?
				componentpath = config.component.paths[component]

			unless componentpath?
				componentpath = component

			if config.component?.overrides?[component+'#'+module]?
				path = config.component.overrides[component+'#'+module]
			else
				path = componentpath+'/'+module

			req [path], (module) ->
				load(module)

		normalize: (name, normalize) ->
			normalize(name)

		write: (pluginName, moduleName, write) ->
			#console.log "Write:", pluginName, moduleName, write
	return new RequireComponent

		