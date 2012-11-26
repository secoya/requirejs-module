define ['cs!dummyClass'], (DummyClass) ->
	class ExtendedDummyClass extends DummyClass
		foo: () ->
			@extendedfoo = true
			super

		bar: () ->
			@extendedbar = true
			super

		baz: () ->
			@extendedbaz = true