define [], () ->
	class OverriddenDummyClass
		foo: () ->
			console.log 'i have been overridden: foo'

		bar: () ->
			console.log 'i have been overridden: bar'