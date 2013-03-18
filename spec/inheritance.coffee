define [], () ->
	describe "fetch overridden module classes, that extends their module base class: ", () ->

		it "should fetch a overridden module class, that extends a base module class", () ->
			ExtendedClass = null
			BaseClass = null

			runs (() -> require ['module!inheritance1#class'], (module) -> ExtendedClass = module)
			runs (() -> require ['spec/modules/inheritance1/overridables/class'], (module) -> BaseClass = module)
			
			waitsFor (() -> ExtendedClass?), "extended module class to be loaded", 5000
			waitsFor (() -> BaseClass?), "base module class to be loaded", 5000

			runs () ->
				inherited = (new ExtendedClass) instanceof BaseClass
				(expect inherited).toBe true
				(expect (new BaseClass).prop).toBe "base class"
				(expect (new ExtendedClass).prop).toBe "extended class"

		it "should fetch a overridden module class, that doesn't extend the module", () ->
			OverriddenClass = null
			BaseClass = null

			runs (() -> require ['module!inheritance2#class'], (module) -> OverriddenClass = module)
			runs (() -> require ['spec/modules/inheritance2/overridables/class'], (module) -> BaseClass = module)

			waitsFor (() ->	OverriddenClass?), "extended module class to be loaded", 5000
			waitsFor (() -> BaseClass?), "base module class to be loaded", 5000

			runs () ->
				inherited = (new OverriddenClass) instanceof BaseClass
				(expect inherited).toBe false
				(expect (new OverriddenClass).prop).toBe "extended class"
				(expect (new BaseClass).prop).toBe "base class"