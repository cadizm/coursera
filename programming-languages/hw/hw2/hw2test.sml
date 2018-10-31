
use "hw2.sml";

val test1a = all_except_option("string", ["string"]) = SOME []
val test1b = all_except_option("a", []) = NONE
val test1c = all_except_option("a", ["b"]) = NONE
val test1d = all_except_option("a", ["a", "b"]) = SOME ["b"]
val test1e = all_except_option("a", ["b", "a"]) = SOME ["b"]
val test1f = all_except_option("b", ["a", "b", "c"]) = SOME ["a", "c"]
val test1g = all_except_option("c", ["a", "b", "c"]) = SOME ["a", "b"]

val test2a = get_substitutions1([["foo"],["there"]], "foo") = []
val test2b = get_substitutions1([["foo", "bar"], ["baz", "foo"]], "foo") = ["bar", "baz"]
val test2c = get_substitutions1([["Fred","Fredrick"],["Elizabeth","Betty"],
                                 ["Freddie","Fred","F"]
                                ],
                                "Fred") = ["Fredrick","Freddie","F"]
val test2d = get_substitutions1([["Fred","Fredrick"],["Jeff","Jeffrey"],
                                 ["Geoff","Jeff","Jeffrey"]
                                ], "Jeff") = ["Jeffrey","Geoff","Jeffrey"]


val test3a = get_substitutions2([["foo"],["there"]], "foo") = []
val test3b = get_substitutions2([["foo", "bar"], ["baz", "foo"]], "foo") = ["bar", "baz"]
val test3c = get_substitutions2([["Fred","Fredrick"],["Elizabeth","Betty"],
                                 ["Freddie","Fred","F"]
                                ],
                                "Fred") = ["Fredrick","Freddie","F"]

val test3d = get_substitutions2([["Fred","Fredrick"],["Jeff","Jeffrey"],
                                 ["Geoff","Jeff","Jeffrey"]
                                ], "Jeff") = ["Jeffrey","Geoff","Jeffrey"]

val test4a = similar_names([["Fred","Fredrick"],["Elizabeth","Betty"],
                           ["Freddie","Fred","F"]],
                          {first="Fred", middle="W", last="Smith"}) =
    [{first="Fred", last="Smith", middle="W"},
     {first="Fredrick", last="Smith", middle="W"},
     {first="Freddie", last="Smith", middle="W"},
     {first="F", last="Smith", middle="W"}
    ]

val test4b = similar_names([["NOTFred","Fredrick"],["Elizabeth","Betty"],
                           ["Freddie","NOTFred","F"]],
                          {first="Fred", middle="W", last="Smith"}) =
    [{first="Fred", last="Smith", middle="W"}
    ]

val test5a = card_color((Clubs, Num 2)) = Black
val test5b = card_color((Diamonds, Num 2)) = Red
val test5c = card_color((Hearts, Num 2)) = Red
val test5d = card_color((Spades, Num 2)) = Black

val test6a = card_value((Clubs, Num 2)) = 2
val test6b = card_value((Diamonds, Jack)) = 10
val test6c = card_value((Hearts, Queen)) = 10
val test6d = card_value((Spades, King)) = 10
val test6e = card_value((Clubs, Ace)) = 11
val test6f = card_value((Diamonds, Num 10)) = 10
val test6g = card_value((Clubs, Num 7)) = 7

val test7a = remove_card([(Hearts, Ace)], (Hearts, Ace), IllegalMove) = []
val test7b = remove_card([(Diamonds, Ace)], (Hearts, Ace), IllegalMove)
handle IllegalMove => [(Diamonds, Ace)]
val test7c = remove_card([(Hearts, Ace),
                          (Hearts, Ace)
                         ],
                         (Hearts, Ace), IllegalMove) = [(Hearts, Ace)]
val test7d = remove_card([(Diamonds, Num 3),
                          (Hearts, Ace)
                         ],
                         (Hearts, Ace), IllegalMove) = [(Diamonds, Num 3)]
val test7e = remove_card([(Diamonds, Num 3),
                          (Hearts, Ace),
                          (Spades, Num 7)
                         ],
                         (Hearts, Ace), IllegalMove) = [(Diamonds, Num 3),
                                                        (Spades, Num 7)
                                                       ]

val test8a = all_same_color([(Hearts, Ace), (Hearts, Ace)]) = true
val test8b = all_same_color([(Hearts, Ace), (Diamonds, Ace)]) = true
val test8c = all_same_color([(Diamonds, Ace), (Spades, Ace)]) = false
val test8d = all_same_color([(Hearts, Ace), (Clubs, Ace)]) = false
val test8e = all_same_color([(Hearts, Ace)]) = true
val test8f = all_same_color([]) = true

val test9a = sum_cards([(Clubs, Num 2),(Clubs, Num 2)]) = 4
val test9b = sum_cards([(Clubs, King),(Clubs, Num 2)]) = 12
val test9c = sum_cards([(Clubs, Ace),(Clubs, Jack)]) = 21

val test10a = score([(Hearts, Num 2),(Clubs, Num 4)],10) = 4
val test10b = score([(Hearts, Num 2),(Clubs, Num 4)],1) = 15
val test10c = score([(Hearts, Num 2),(Diamonds, Num 4)],1) = 7
val test10d = score([(Hearts, Num 2),(Clubs, Num 4)],20) = 14
val test10e = score([(Hearts, Num 2),(Diamonds, Num 4)],20) = 7
val test10f = score([],0) = 0

val test11a = officiate([(Hearts, Num 2),(Clubs, Num 4)],[Draw], 15) = 6
val test11b = officiate([(Hearts, Num 2),(Clubs, Num 4)],[], 15) = 0
val test11c = officiate([],[], 15) = 0

val test12 = officiate([(Clubs,Ace),(Spades,Ace),(Clubs,Ace),(Spades,Ace)],
                       [Draw,Draw,Draw,Draw,Draw],
                       42)
             = 3

val test13 = ((officiate([(Clubs,Jack),(Spades,Num(8))],
                         [Draw,Discard(Hearts,Jack)],
                         42);
               false)
              handle IllegalMove => true)
