define [], () ->
	class BaseClass
		prop: null

		constructor: () ->
			@func()
		
		func: () ->
			@prop = "base class"
