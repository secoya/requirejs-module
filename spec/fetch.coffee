define [], () ->
	describe "fetch", () ->

		it "Should fetch a module class, without overrides", () ->
			ModuleFetchedFileClass = null
			RequireFetchedFileClass = null
			runs () ->
				require ['module!fetch1#file'], (module) ->
					ModuleFetchedFileClass = module

			waitsFor (() ->
				return ModuleFetchedFileClass?
			), "Module fetched File class to be loaded", 5000

			runs () ->
				require ['spec/modules/fetch1/overridables/file'], (module) ->
					RequireFetchedFileClass = module

			waitsFor (() ->
				return RequireFetchedFileClass?
			), "Require fetched File class to be loaded", 5000

			runs () ->
				(expect ModuleFetchedFileClass).toEqual RequireFetchedFileClass

		it "Should fetch a module class, with overrides", () ->
			ModuleFetchedFileClass = null
			RequireFetchedFileClass = null
			runs () ->
				require ['module!fetch2#file'], (module) ->
					ModuleFetchedFileClass = module
			
			waitsFor (() ->
				return ModuleFetchedFileClass?
			), "Module fetched File class to be loaded", 5000

			runs () ->
				require ['spec/app/fetch2/file'], (module) ->
					RequireFetchedFileClass = module

			waitsFor (() ->
				return RequireFetchedFileClass?
			), "Require fetched File class to be loaded", 5000

			runs () ->
				(expect ModuleFetchedFileClass).toEqual RequireFetchedFileClass