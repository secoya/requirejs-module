define ['spec/modules/init2/overridables/init'], (InitBase) ->
	class Init extends InitBase

		func: () ->
			@prop = "Overriden the init2 modules init file"