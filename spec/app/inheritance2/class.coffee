define [], () ->
	class OverriddenClass
		
		constructor: () ->
			@func()

		func: () ->
			@prop = "extended class"