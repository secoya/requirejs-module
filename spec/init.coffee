define [], () ->
	describe "loading a module's default file: ", () ->
		it "should fetch a default file from a module, that is not overridden", () ->
			ModuleFetchedDefaultClass = null
			RequireFetchedDefaultClass = null

			runs () -> (require ['module!init1'], (module) -> ModuleFetchedDefaultClass = module)
			runs () -> (require ['spec/modules/init1/overridables/init'], (module) -> RequireFetchedDefaultClass = module)
			
			waitsFor (() -> ModuleFetchedDefaultClass?) , "Module fetched default class to be loaded", 5000
			waitsFor (() -> RequireFetchedDefaultClass?), "Require fetched default class to be loaded", 5000
			
			runs () -> (expect ModuleFetchedDefaultClass).toEqual RequireFetchedDefaultClass

		it "should fetch a default file from a module, that is overriden", () ->
			ModuleFetchedDefaultClass = null
			RequireFetchedDefaultClass = null

			runs () -> (require ['module!init2'], (module) -> ModuleFetchedDefaultClass = module)
			runs () -> (require ['spec/app/init2/init'], (module) -> RequireFetchedDefaultClass = module)
			
			waitsFor (() -> ModuleFetchedDefaultClass?), "Module fetched default class to be loaded", 5000
			waitsFor (() -> RequireFetchedDefaultClass?), "Require fetched default class to be loaded", 5000
			
			runs () -> (expect ModuleFetchedDefaultClass).toEqual RequireFetchedDefaultClass