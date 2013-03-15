define ['spec/modules/inheritance1/overridables/class'], (BaseClass) ->
	class ExtendedClass extends BaseClass
		
		func: () ->
			@prop = "extended class"