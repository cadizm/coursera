
(**
 * Michael Cadiz
 * cadizm (at) 0xfa.de
 * Sat Oct 18 01:21:16 PDT 2014
 *)


use "hw1.sml";

val test1a = is_older((1,2,3),(2,3,4)) = true
val test1b = is_older((1,2,3),(1,3,4)) = true
val test1c = is_older((1,2,3),(1,2,4)) = true
val test1d = is_older((1,2,3),(1,2,3)) = false
val test1e = is_older((2,3,4),(1,2,3)) = false
val test1f = is_older((2,3,4),(2,2,3)) = false
val test1g = is_older((2,3,4),(2,3,3)) = false


val test2a = number_in_month([(2012,2,28),(2013,12,1)],2) = 1
val test2b = number_in_month([(2012,2,28),
                              (2013,12,1),
                              (2013,2,1),
                              (2013,12,1),
                              (2013,2,1),
                              (2013,2,1)
                             ],
                             2) = 4

val test2c = number_in_month([(2012,3,28),(2013,12,1)],2) = 0
val test2d = number_in_month([],2) = 0

val test3a = number_in_months([(2012,2,28),
                               (2013,12,1),
                               (2011,3,31),
                               (2011,4,28)
                              ],
                              [2,3,4]) = 3
val test3b = number_in_months([(2012,2,28),
                               (2013,12,1),
                               (2011,3,31),
                               (2011,4,28)
                              ],
                              [6,7,8]) = 0
val test3c = number_in_months([(2012,2,28),
                               (2013,2,1),
                               (2011,2,31),
                               (2011,2,28)
                              ],
                              [6,2,8]) = 4

val test4a = dates_in_month([(2012,2,28),
                             (2013,12,1)],
                            2) = [(2012,2,28)]
val test4b = dates_in_month([(2012,2,28),
                             (2013,12,1)],
                            3) = []
val test4c = dates_in_month([(2012,1,28),
                             (2013,11,1),
                             (2011,11,1),
                             (2011,9,1),
                             (2011,8,1),
                             (2011,11,1)],
                           11) = [(2013,11,1),
                                  (2011,11,1),
                                  (2011,11,1)
                                 ]

val test5a = dates_in_months([(2012,2,28),
                              (2013,12,1),
                              (2011,3,31),
                              (2011,4,28)
                             ],
                             [2,3,4]) = [(2012,2,28),
                                         (2011,3,31),
                                         (2011,4,28)
                                        ]
val test5b = dates_in_months([(2012,2,28),
                              (2013,12,1),
                              (2011,3,31),
                              (2011,4,28)
                             ],
                             [8,9,10]) = []
val test5c = dates_in_months([(2012,2,28),
                              (2013,8,1),
                              (2013,7,1),
                              (2013,10,1),
                              (2011,3,31),
                              (2011,4,28)
                             ],
                             [8,9,4,10]) = [(2013,8,1),
                                            (2011,4,28),
                                            (2013,10,1)
                                           ]

val test6a = get_nth(["hi", "there", "how", "are", "you"], 2) = "there"
val test6b = get_nth(["hi", "there", "how", "are", "you"], 1) = "hi"
val test6c = get_nth(["hi", "there", "how", "are", "you"], 3) = "how"
val test6d = get_nth(["hi", "there", "how", "are", "you"], 4) = "are"
val test6e = get_nth(["hi", "there", "how", "are", "you"], 5) = "you"

val test7a = date_to_string((2013, 6, 1)) = "June 1, 2013"
val test7b = date_to_string((3030, 5, 18)) = "May 18, 3030"

val test8a = number_before_reaching_sum(10, [1,2,3,4,5]) = 3
val test8b = number_before_reaching_sum(1, [1,1]) = 0
val test8c = number_before_reaching_sum(2, [1,1]) = 1
val test8d = number_before_reaching_sum(20, [1,2,3,4,5,6,7]) = 5
val test8e = number_before_reaching_sum(21, [1,2,3,4,5,6,7]) = 5

val test9a = what_month(70) = 3
val test9b = what_month(1) = 1
val test9c = what_month(40) = 2
val test9d = what_month(334) = 11
val test9e = what_month(365) = 12

val test10a = month_range(31, 34) = [1,2,2,2]
val test10b = month_range(2, 1) = []
val test10c = month_range(182, 244) = [7, 7, 7, 7, 7, 7, 7, 7, 7, 7,
                                       7, 7, 7, 7, 7, 7, 7, 7, 7, 7,
                                       7, 7, 7, 7, 7, 7, 7, 7, 7, 7,
                                       7,
                                       8, 8, 8, 8, 8, 8, 8, 8, 8, 8,
                                       8, 8, 8, 8, 8, 8, 8, 8, 8, 8,
                                       8, 8, 8, 8, 8, 8, 8, 8, 8, 8,
                                       8,
                                       9
                                      ]

val test11a = oldest([(2012,2,28),
                      (2011,3,31),
                      (2011,4,28)]) = SOME (2011,3,31)
val test11b = oldest([]) = NONE
val test11c = oldest([(2011,3,31),
                      (2012,2,28),
                      (2011,4,28)]) = SOME (2011,3,31)
val test11d = oldest([(2011,3,31),
                      (2012,2,28),
                      (2000,4,28)]) = SOME (2000,4,28)

val test_contains1 = contains(1, [1, 2, 3]) = true
val test_contains2 = not(contains(1, [1, 2, 3])) = false
val test_contains3 = contains(0, [1, 2, 3]) = false
val test_contains4 = not(contains(0, [1, 2, 3])) = true

val test12a = number_in_months_challenge([(2012,2,28),
                                          (2013,12,1),
                                          (2011,3,31),
                                          (2011,4,28)
                                         ],
                                         [2,3,2,4]) = 3
val test12b = number_in_months_challenge([(2012,2,28),
                                          (2013,12,1),
                                          (2011,3,31),
                                          (2011,6,31),
                                          (2011,9,31),
                                          (2011,12,31),
                                          (2011,4,28)
                                         ],
                                         [12,3,2,3,2,4,12]) = 5
val test12c = dates_in_months_challenge([(2012,2,28),
                               (2013,12,1),
                               (2011,3,31),
                               (2011,4,28)
                              ],
                              [2,3,2,4]) = [(2012,2,28),
                                            (2011,3,31),
                                            (2011,4,28)
                                           ]

val test13a = reasonable_date((2014, 10, 8)) = true;
val test13b = reasonable_date((2014, 2, 29)) = false;
val test13c = reasonable_date((2020, 2, 29)) = true;
val test13d = reasonable_date((2014, 4, 31)) = false;
val test13e = reasonable_date((2014, 7, 31)) = true;
