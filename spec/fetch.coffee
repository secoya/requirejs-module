define [], () ->
	describe "fetch module classes: ", () ->

		it "should fetch a module class, from base module, because it has not been overriden", () ->
			ModuleFetchedFileClass = null
			RequireFetchedFileClass = null
			
			runs (() -> require ['module!fetch1#file'], (module) -> ModuleFetchedFileClass = module)
			runs (() -> require ['spec/modules/fetch1/overridables/file'], (module) -> RequireFetchedFileClass = module)

			waitsFor (() -> ModuleFetchedFileClass?), "module fetched File class to be loaded", 5000
			waitsFor (() -> RequireFetchedFileClass?), "require fetched File class to be loaded", 5000

			runs () -> (expect ModuleFetchedFileClass).toEqual RequireFetchedFileClass

		it "should fetch a module class, from the application specific folder", () ->
			ModuleFetchedFileClass = null
			RequireFetchedFileClass = null
			
			runs (() -> require ['module!fetch2#file'], (module) -> ModuleFetchedFileClass = module)
			runs (() -> require ['spec/app/fetch2/file'], (module) -> RequireFetchedFileClass = module)

			waitsFor (() -> ModuleFetchedFileClass?), "module fetched File class to be loaded", 5000
			waitsFor (() -> RequireFetchedFileClass?), "require fetched File class to be loaded", 5000

			runs () -> (expect ModuleFetchedFileClass).toEqual RequireFetchedFileClass