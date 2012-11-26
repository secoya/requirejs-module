define ['cs!dummyClass'], (DummyClass) ->
	class ExtendedDummyClass extends DummyClass
		foo: () ->
			@extendedfoo = true
			console.log "foo: i've been overriden and extended"
			super

		bar: () ->
			@extendedbar = true
			console.log "bar: i've been overridden and extended"
			super

		baz: () ->
			@extendedbaz = true
			console.log 'baz'