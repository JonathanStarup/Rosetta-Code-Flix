mod Test.Rosetta_100_doors {
    use Test.assertEq
    use Test.{runWithIO => runTest}

    def answer(): Vector[Bool] = Vector#{
        true,  false, false, true,  false, false, false, false, true,  false,
        false, false, false, false, false, true,  false, false, false, false,
        false, false, false, false, true,  false, false, false, false, false,
        false, false, false, false, false, true,  false, false, false, false,
        false, false, false, false, false, false, false, false, true,  false,
        false, false, false, false, false, false, false, false, false, false,
        false, false, false, true,  false, false, false, false, false, false,
        false, false, false, false, false, false, false, false, false, false,
        true,  false, false, false, false, false, false, false, false, false,
        false, false, false, false, false, false, false, false, false, true
    }

    @Test
    pub def imperative(): Bool \ IO = run {
        assertEq(expect = answer(), Rosetta_100_doors.mainImperative())
    } with runTest

    @Test
    pub def functional(): Bool \ IO = run {
        Test.assertEq(expect = answer(), Rosetta_100_doors.mainFunctional())
    } with runTest

    @Test
    pub def freeForm(): Bool \ IO = run {
        Test.assertEq(expect = answer(), Rosetta_100_doors.mainImperative())
    } with runTest

}
