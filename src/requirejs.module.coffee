###*
 * RequireJS module plugin
 * @author Brian K. Christensen, Secoya A/S <bkc@secoya.dk>
 * @version 0.9.1
 * @license BSD
###
define [], () ->
	class RequireModule

		_config: 
			appBasePath: 'app'
			moduleBasePath: 'modules'
			relativeModuleOverridePath: 'overridables'
			defaultModuleName: 'init'

		buildMap: {}

		_extendConfig: (source, target) ->
			source ?= {}
			for k, v of source
				target[k] ?= v
			return target

		load: (name, req, load, config) ->
			moduleConfig = config._module
			@_extendConfig @_config, moduleConfig
			[component, module] = name.split '#'

			# the default file to load in
			module = 'init' unless module?

			componentpath = "#{config.component.path}/#{component}" if config.component?.path?
			componentpath = config.component.paths[component] if config.component?.paths?[component]?
			componentpath = component unless componentpath?
			
			specificPath = "#{moduleConfig['appBasePath']}/#{componentpath}/#{module}"

			# loading application overriden files.
			req [specificPath], (module) ->
				load module
			, (err) ->
				modulePath = "#{moduleConfig['moduleBasePath']}/#{componentpath}/#{moduleConfig['relativeModuleOverridePath']}/#{module}"
				# loading modules files if application specific wasn't there.
				req [modulePath], (module) ->
					load module

		normalize: (name, normalize) ->
			normalize name

	return new RequireModule