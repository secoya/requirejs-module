define [
	'src/test_component/testclass'
	"src/overrideclass"
], (TestClassOrgPrototype, OverrideClassPrototype) ->
	describe "client", () ->

		beforeEach () ->
			TestClassOrg = new TestClassOrgPrototype()
			OverrideClass = new OverrideClassPrototype()

			for orgprop of TestClassOrgPrototype when typeof TestClassOrgPrototype[orgprop] is 'function'
				spyOn TestClassOrgPrototype, orgprop

			for newprop of OverrideClassPrototype when typeof OverrideClassPrototype[orgprop] is 'function'
				spyOn OverrideClassPrototype, newprop

		it "Should fetch a module from a component", () ->
			require ['com!test_component#testclass'], (TestClass) =>
				expect(TestClass).toEqual(TestClassOrg)

		it "Should be able to override a module with another module", () ->
			requirejs.config
				component:
					overrides:
						"test_component#testclass": 'src/overrideclass', 

			require [
				'com!test_component#testclass', 
			], (TestClass) ->
				for newprop of OverrideClass
					expect(TestClass[newprop]).toBeDefined()
				for orgprop of TestClassOrg
					expect(TestClass[orgprop]).toBeDefined()

		it "Should maintain the correct prototype chain", () ->
			# We already overrode the testclass before.
			require [
				'com!test_component#testclass', 
			], (TestClass) ->
				for orgprop of TestClassOrg when typeof TestClassOrg[orgprop] is 'function'
					TestClass[orgprop]()
					expect(TestClassOrg[orgprop]).toHaveBeenCalled()

				for orgprop of OverrideClass when typeof OverrideClass[orgprop] is 'function'
					TestClass[orgprop]()
					expect(OverrideClass[orgprop]).toHaveBeenCalled()
				

	describe("Player", function() {