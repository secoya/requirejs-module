define [], () ->
	class DummyClass

		foo: () ->
			@basefoo = true
			console.log 'foo'

		bar: () ->
			@basebar = true
			console.log 'bar'