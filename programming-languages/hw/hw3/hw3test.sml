
use "hw3.sml";

val test1a = only_capitals ["A","B","C"] = ["A","B","C"]
val test1b = only_capitals ["z", "A", "B", "d", "C"] = ["A","B","C"]

val test2a = longest_string1 ["A","bc","C"] = "bc"
val test2b = longest_string1 ["A", "bc" ,"C", "defg", "jij"] = "defg"
val test2c = longest_string1 ["A", "bc" ,"C", "defg", "hijk"] = "defg"

val test3a = longest_string2 ["A","bc","C"] = "bc"
val test3b = longest_string2 ["A", "bc", "de", "C"] = "de"
val test3c = longest_string2 ["A", "bc", "de", "fg", "C"] = "fg"
val test3d = longest_string2 ["A","B","C"] = "C"

val test4a = longest_string3 ["A","bc","C"] = "bc"
val test4b = longest_string3 ["A", "bc", "de", "C"] = "bc"
val test4c = longest_string3 ["A", "bc", "de", "fg", "C"] = "bc"
val test4d = longest_string3 ["A", "bc", "de", "fg", "CCCC", "DD"] = "CCCC"

val test4e = longest_string4 ["A","bc","C"] = "bc"
val test4f = longest_string4 ["A", "bc", "de", "C"] = "de"
val test4g = longest_string4 ["A", "bc", "de", "fg", "C"] = "fg"
val test4h = longest_string4 ["A","B","C"] = "C"

val test5a = longest_capitalized ["A","bc","C"] = "A";
val test5b = longest_capitalized ["defg", "A","bc","Ab", "C"] = "Ab";

val test6a = rev_string "abc" = "cba";
val test6b = rev_string "abcXYZ" = "ZYXcba";

val test7a = first_answer (fn x => if x > 3 then SOME x else NONE) [1,2,3,4,5] = 4
val test7b = first_answer (fn x => if x > 3 then SOME x else NONE) [1,2,3,4,5] = 4

val test8a = all_answers (fn x => if x = 1 then SOME [x] else NONE) [2,3,4,5,6,7] = NONE
val test8b = all_answers (fn x => if x = 1 then SOME [x] else NONE) [1] = SOME [1]
val test8c = all_answers (fn x => if x = 1 then SOME [x] else NONE) [1,2,3,4,5,6,7] = NONE
val test8d = all_answers (fn x => if x = 1 then SOME [x] else NONE) [2,3,4,5,6,7,1] = NONE
val test8e = all_answers (fn x => if x = 1 then SOME [x] else NONE) [1,2,3,4,5,6,7,1] = NONE
val test8f = all_answers (fn x => if x = 1 then SOME [x] else NONE) [] = SOME []
val test8g = all_answers (fn x => if x = 1 then SOME [x] else NONE) [1,1] = SOME [1,1]

val test9a1 = count_wildcards Wildcard = 1
val test9a2 = count_wildcards (TupleP [Wildcard]) = 1
val test9a3 = count_wildcards (TupleP [Wildcard,Wildcard]) = 2
val test9b1 = count_wild_and_variable_lengths (Variable("a")) = 1
val test9b2 = count_wild_and_variable_lengths (TupleP [Variable("abc"), Wildcard]) = 4
val test9c1 = count_some_var ("x", Variable("x")) = 1;
val test9c2 = count_some_var ("x", Variable("y")) = 0;
val test9c3 = count_some_var ("x", (TupleP [Variable("y"), Variable("x")])) = 1;
val test9c4 = count_some_var ("x", (TupleP [Wildcard, Variable("x"), Variable("y"), Variable("x")])) = 2;

val test10a = check_pat (Variable("x")) = true
val test10b = check_pat (TupleP [Variable("x"), Variable("y"), Variable("x"), Wildcard]) = false
val test10c = check_pat (TupleP[TupleP[Variable "x",ConstructorP ("wild",Wildcard)],Variable "x"]) = false
val test10d = check_pat (TupleP[TupleP[TupleP[Variable "x",ConstructorP ("wild",Wildcard)],Wildcard],Variable "x"]) = false
val test10e = check_pat (ConstructorP ("hi",TupleP[Variable "x",Variable "x"])) = false
val test10f = check_pat (ConstructorP ("hi",TupleP[Variable "x",ConstructorP ("yo",TupleP[Variable "x",UnitP])])) = false

val test11a = match (Const(1), UnitP) = NONE
val test11b = match (Const(1), ConstP(1)) = SOME []
val test11c = match (Const(1), ConstP(2)) = NONE
val test11d = match (Const(1), Wildcard) = SOME []
val test11e = match (Const(1), Variable("x")) = SOME [("x", Const(1))]
val test11f = match (Unit, UnitP) = SOME []
val test11g = match (Const(1), UnitP) = NONE
val test11h = match (Tuple[Unit, Const(1)], TupleP [Wildcard, ConstP(1)]) = SOME []
val test11i = match (Tuple[Unit, Const(1)], TupleP [Variable("x"), ConstP(1)]) = SOME [("x", Unit)]
val test11j = match (Constructor("x", Unit), ConstructorP("y", Wildcard)) = NONE
val test11k = match (Constructor("x", Unit), ConstructorP("x", Variable("y"))) = SOME [("y", Unit)]

val test12a = first_match Unit [UnitP] = SOME []
val test12b = first_match (Constructor("x", Unit)) [UnitP] = NONE
