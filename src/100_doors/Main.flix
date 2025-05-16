//
// https://rosettacode.org/wiki/100_doors
//
// There are 100 doors in a row that are all initially closed.
//
// You make 100 passes by the doors.
//
// The first time through, visit every door and toggle the door (if the door is
// closed, open it; if it is open, close it).
//
// The second time, only visit every 2nd door (door #2, #4, #6, ...), and toggle
// it.
//
// The third time, visit every 3rd door (door #3, #6, #9, ...), etc, until you
// only visit the 100th door.
//
// Task
//
// Answer the question: what state are the doors in after the last pass? Which are open, which are closed?
//
mod Rosetta_100_doors {
    use Add.add

    pub def mainImperative(): Vector[Bool] = unsafely OutOfBounds run region local {
        let init = Array.repeat(local, 100, false);
        foreach (start <- Vector.range(0, 100)) {
            let i = Ref.fresh(local, start);
            let skip = start + 1;
            while(() -> Ref.get(i) < 100)(() -> {
                init[Ref.get(i)] = not init[Ref.get(i)];
                i |> Ref.transform(add(skip))
            })
        };
        init |> Array.toVector
    }

    /// If `cond` returns true, run `body` and repeat.
    def while(cond: Unit -> Bool \ ef1, body: Unit -> Unit \ ef2): Unit \ ef1 + ef2 = {
        if (cond()) {
            body();
            while(cond, body)
        } else {
            ()
        }
    }

    pub def mainFunctional(): Vector[Bool] = {
        let init = Vector.repeat(100, false);
        def traverse(acc, i) = {
            if (i >= 100) acc
            else traverse(swapVector(i, acc), i+1)
        };
        traverse(init, 0)
    }

    def swapVector(skip: Int32, v: Vector[Bool]): Vector[Bool] = {
        v |> Vector.mapWithIndex((i, d) -> {
            if (Int32.modulo(i + 1, skip + 1) == 0) not d
            else d
        })
    }

    pub def mainFreeForm(): Vector[Bool] = region local {
        let init = Array.repeat(local, 100, false);
        foreach (i <- Vector.range(0, 100)) {
            swapArray(i + 1, i, init)
        };
        init |> Array.toVector
    }

    def swapArray(n: Int32, idx: Int32, arr: Array[Bool, r]): Unit \ r =
        checked_ecast(unsafely OutOfBounds run {
            if (idx >= Array.length(arr)) ()
            else {
                arr[idx] = not arr[idx];
                swapArray(n, idx + n, arr)
            }
        })

}
