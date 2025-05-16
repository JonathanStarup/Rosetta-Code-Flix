mod Test {

    eff Test {
        def fail(msg: String): Void
    }

    def runWithIO(f: Unit -> Unit \ ef): Bool \ ef - Test + IO = {
        run {f(); true} with handler Test {
            def fail(msg, _) = {
                println("TEST FAIL:\n${String.indent(2, msg)}");
                false
            }
        }
    }

    def assertEq(expect: {expect = t}, actual: t): Unit \ Test with Eq[t], ToString[t] = {
        if (expect#expect == actual) ()
        else Test.fail("Expected ${expect#expect}\nFound:   ${actual}")
    }
}
