define [
	'cs!test_component/testclass'
	"cs!overrideDummy"
	"cs!overrideAndExtend"
], (TestClassOrgPrototype, OverrideClassPrototype, ExtendClassPrototype) ->
	describe "client", () ->

		TestClassOrg = null
		OverrideClass = null
		ExtendClass = null

		testHasSpy = {}
		overrideHasSpy = {}
		extendHasSpy = {}


		beforeEach () ->
			TestClassOrg = new TestClassOrgPrototype()
			OverrideClass = new OverrideClassPrototype()
			ExtendClass = new ExtendClassPrototype()

		it "Should fetch a module from a component", () ->

			TestClass = null

			runs () ->
				require ['com!test_component#testclass'], (module) =>
					TestClass = module

			waitsFor (() ->
				return TestClass?
			), "the TestClass to be loaded", 5000

			runs () ->
				expect(TestClass).toEqual(TestClassOrgPrototype)

		it "Should be able to override a module with another module", () ->
			
			TestClass = null

			runs () ->
				requirejs.config
					component:
						overrides:
							"test_component#testclass": 'cs!overrideDummy', 
				require ['com!test_component#testclass'], (module) =>
					TestClass = module

			waitsFor (() ->
				return TestClass?
			), "the TestClass to be loaded", 5000

			runs () ->
				instance = new TestClass()
				for newprop of OverrideClass
					#console.log newprop, instance[newprop]
					expect(instance[newprop]).toBeDefined()
				for orgprop of TestClassOrg
					#console.log orgprop, instance[orgprop]
					expect(instance[orgprop]).toBeDefined()

		it "Should be able to extend", () ->
			TestClass = null

			runs () ->
				require.undef('com!test_component#testclass')
				requirejs.config
					component:
						overrides:
							"test_component#testclass": 'cs!overrideAndExtend', 

				require ['com!test_component#testclass'], (module) =>
					TestClass = module

			waitsFor (() ->
				return TestClass?
			), "the TestClass to be loaded", 5000

			runs () ->
				instance = new TestClass()
				expect(instance instanceof TestClassOrg).toEqual(true)
				expect(instance instanceof ExtendClass).toEqual(true)
