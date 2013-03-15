define [], () ->
	describe "inheritance", () ->

		it "Should fetch a overridden module class, that extends a base module class", () ->
			ExtendedClass = null
			BaseClass = null

			runs () ->
				require ['module!inheritance1#class'], (module) ->
					ExtendedClass = module

			waitsFor (() ->
				return ExtendedClass?
			), "Extended module class to be loaded", 5000

			runs () ->
				require ['spec/modules/inheritance1/overridables/class'], (module) ->
					BaseClass = module

			waitsFor (() ->
				return BaseClass?
			), "Base module class to be loaded", 5000


			runs () ->
				inherited = (new ExtendedClass) instanceof BaseClass
				(expect inherited).toBe true
				(expect (new BaseClass).prop).toBe "base class"
				(expect (new ExtendedClass).prop).toBe "extended class"

		it "Should fetch a overridden module class, that doesn't extend the module", () ->
			OverriddenClass = null
			BaseClass = null

			runs () ->
				require ['module!inheritance2#class'], (module) ->
					OverriddenClass = module

			waitsFor (() ->
				return OverriddenClass?
			), "Extended module class to be loaded", 5000

			runs () ->
				require ['spec/modules/inheritance2/overridables/class'], (module) ->
					BaseClass = module

			waitsFor (() ->
				return BaseClass?
			), "Base module class to be loaded", 5000


			runs () ->
				inherited = (new OverriddenClass) instanceof BaseClass
				(expect inherited).toBe false
				(expect (new OverriddenClass).prop).toBe "extended class"
				(expect (new BaseClass).prop).toBe "base class"