define [], () ->
	class InitBase
		
		prop: null

		constructor: () ->
			@func()

		func: () ->
			@prop = "base init class of the init2 module"