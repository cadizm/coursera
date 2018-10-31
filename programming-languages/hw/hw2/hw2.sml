
(**
 * Michael Cadiz
 * cadizm (at) 0xfa.de
 * Sat Oct 25 21:41:35 PDT 2014
 *)


(**
 * If you use this function to compare two strings, then you avoid several
 * of the functions in problem 1 having polymorphic types that may be
 * confusing.
 *
 * Returns true if the same string
 *)
fun same_string(s1 : string, s2 : string) =
    s1 = s2


(**
 * 1. This problem involves using first-name substitutions to come up with
 * alternate names. For example, Fredrick William Smith could also be Fred
 * William Smith or Freddie William Smith. Only part (d) is specifically about
 * this, but the other problems are helpful.
 *)

(**
 * a) Write a function all_except_option, which takes a string and a string
 * list. Return NONE if the string is not in the list, else return SOME lst
 * where lst is identical to the argument list except the string is not in it.
 * You may assume the string is in the list at most once. Use same_string,
 * provided to you, to compare strings. Sample solution is around 8 lines.
 *)
fun all_except_option(s, slist) =
    let fun all_except_option(s, slist, acc) =
    case slist of
        [] => NONE
        | x::xs =>
            if s = x
            then SOME (acc @ xs)
            else all_except_option(s, xs, acc @ [x])
    in
        all_except_option(s, slist, [])
    end


(**
 * (b) Write a function get_substitutions1, which takes a string list list
 * (a list of list of strings, the substitutions) and a string s and returns
 * a string list. The result has all the strings that are in some list in
 * substitutions that also has s, but s itself should not be in the result.
 *
 * Example:
 *   get_substitutions1([["Fred","Fredrick"],["Elizabeth","Betty"],
 *                      ["Freddie","Fred","F"]], "Fred")
 *
 *   Answer: ["Fredrick","Freddie","F"]
 *
 * Assume each list in substitutions has no repeats. The result will have
 * repeats if s and another string are both in more than one list in
 * substitutions.
 *
 * Example:
 *   get_substitutions1([["Fred","Fredrick"],["Jeff","Jeffrey"],
 *                      ["Geoff","Jeff","Jeffrey"]], "Jeff")
 *
 *   Answer: ["Jeffrey","Geoff","Jeffrey"]
 *
 * Use part (a) and ML’s list-append (@) but no other helper functions.
 *)
fun get_substitutions1(slistlist, s) =
    case slistlist of
        [] => []
        | x::xs =>
            let val ans = all_except_option(s, x)
            in
                case ans of
                    SOME ans' => ans' @ get_substitutions1(xs, s)
                    | NONE => get_substitutions1(xs, s)
            end


(**
 * (c) Write a function get_substitutions2, which is like get_substitutions1
 * except it uses a tail-recursive local helper function.
 *)
fun get_substitutions2(slistlist, s) =
    let fun get_substitutions2(slistlist, s, acc) =
    case slistlist of
        [] => acc
        | x::xs =>
            let val ans = all_except_option(s, x)
            in
                case ans of
                    SOME ans' => acc @ ans' @ get_substitutions2(xs, s, acc)
                    | NONE => get_substitutions2(xs, s, acc)
            end
    in
        get_substitutions2(slistlist, s, [])
    end


(**
 * d) Write a function similar_names, which takes a string list list of
 * substitutions (as in parts (b) and (c)) and a full name of type
 * { first:string, middle:string, last:string } and returns a list of
 * full names (type { first:string, middle:string, last:string } list).
 * The result is all the full names you can produce by substituting for the
 * first name (and only the first name) using substitutions and parts (b) or
 * (c). The answer should begin with the original name (then have 0 or more
 * other names).
 *
 * Example:
 *   similar_names([["Fred","Fredrick"],
 *                  ["Elizabeth","Betty"],
 *                  ["Freddie","Fred","F"]
 *                 ],
 *                 {first="Fred", middle="W", last="Smith"})
 *
 *   Answer: [{first="Fred", last="Smith", middle="W"},
 *            {first="Fredrick", last="Smith", middle="W"},
 *            {first="Freddie", last="Smith", middle="W"},
 *            {first="F", last="Smith", middle="W"}]
 *
 * Do not eliminate duplicates from the answer. Hint: Use a local helper function.
 * Sample solution is around 10 lines.
 *)
fun similar_names(slistlist, name_type) =
    let
        val {first=first,last=last,middle=middle} = name_type
        val aliases = get_substitutions2(slistlist, first)
        fun apply_aliases(aliases', acc) =
            case aliases' of
                [] => acc
                | x::xs => [{first=x,last=last,middle=middle}] @ apply_aliases(xs, acc)
    in
        [{first=first,last=last,middle=middle}] @ apply_aliases(aliases, [])
    end


(**
 * You may assume that Num is always used with values 2, 3, ..., 10
 *)
datatype suit = Clubs | Diamonds | Hearts | Spades
datatype rank = Jack | Queen | King | Ace | Num of int
type card = suit * rank

datatype color = Red | Black
datatype move = Discard of card | Draw

exception IllegalMove


(**
 * 2. This problem involves a solitaire card game invented just for this
 * question. You will write a program that tracks the progress of a game;
 * writing a game player is a challenge problem. You can do parts (a)–(e)
 * before understanding the game if you wish.
 *
 * A game is played with a card-list and a goal. The player has a list of
 * held-cards, initially empty. The player makes a move by either drawing,
 * which means removing the first card in the card-list from the card-list
 * and adding it to the held-cards, or discarding, which means choosing one
 * of the held-cards to remove. The game ends either when the player chooses
 * to make no more moves or when the sum of the values of the held-cards is
 * greater than the goal.
 *
 * The objective is to end the game with a low score (0 is best). Scoring
 * works as follows: Let sum be the sum of the values of the held-cards. If
 * sum is greater than goal, the preliminary score is three times (sum−goal),
 * else the preliminary score is (goal − sum). The score is the preliminary
 * score unless all the held-cards are the same color, in which case the score
 * is the preliminary score divided by 2 (and rounded down as usual with
 * integer division; use ML’s div operator).
 *)

(**
 * (a) Write a function card_color, which takes a card and returns its color
 * (spades and clubs are black, diamonds and hearts are red). Note: One case-
 * expression is enough.
 *)
fun card_color(card') =
    let val (suit', rank') = card'
    in
        case suit' of
            Diamonds => Red
            | Hearts => Red
            | Spades => Black
            | Clubs => Black
    end


(**
 * (b) Write a function card_value, which takes a card and returns its value
 * (numbered cards have their number as the value, aces are 11, everything
 * else is 10). Note: One case-expression is enough.
 *)
fun card_value(card') =
    let val (suit', rank') = card'
    in
        case rank' of
            Ace => 11
            | King => 10
            | Queen => 10
            | Jack => 10
            | Num n => n
    end


(**
 * (c) Write a function remove_card, which takes a list of cards cs, a card c,
 * and an exception e. It returns a list that has all the elements of cs except
 * c. If c is in the list more than once, remove only the first one. If c is
 * not in the list, raise the exception e. You can compare cards with =.
 *)
fun remove_card(cs, c, e) =
    let val (suit', rank') = c
    in
        case cs of
            [] => raise e
            | x::xs => if x = c
                       then xs
                       else [x] @ remove_card(xs, c, e)
    end


(**
 * d) Write a function all_same_color, which takes a list of cards and returns
 * true if all the cards in the list are the same color. Hint: An elegant
 * solution is very similar to one of the functions using nested pattern-
 * matching in the lectures.
 *)
fun all_same_color(card_list) =
    case card_list of
        [] => true
        | (suit', rank')::cs =>
            let fun all_same_color(card_list, suit'') =
                case (card_list, suit'') of
                    ([], _) =>  true
                    | ((Diamonds, _)::cs, Diamonds) => all_same_color(cs, Diamonds)
                    | ((Diamonds, _)::cs, Hearts) => all_same_color(cs, Hearts)
                    | ((Hearts, _)::cs, Hearts) => all_same_color(cs, Hearts)
                    | ((Hearts, _)::cs, Diamonds) => all_same_color(cs, Diamonds)
                    | ((Spades, _)::cs, Spades) => all_same_color(cs, Spades)
                    | ((Spades, _)::cs, Clubs) => all_same_color(cs, Clubs)
                    | ((Clubs, _)::cs, Clubs) => all_same_color(cs, Clubs)
                    | ((Clubs, _)::cs, Spades) => all_same_color(cs, Spades)
                    | _ => false
            in
                all_same_color(cs, suit')
            end


(**
 * (e) Write a function sum_cards, which takes a list of cards and returns
 * the sum of their values. Use a locally defined helper function that is
 * tail recursive. (Take "calls use a constant amount of stack space" as a
 * requirement for this problem.)
 *)
fun sum_cards(card_list) =
    let
        fun sum_cards(card_list, acc) =
            case card_list of
                [] => acc
                | c::cs => card_value(c) + sum_cards(cs, acc)
    in
        sum_cards(card_list, 0)
    end


(**
 *(f) Write a function score, which takes a card list (the held-cards) and an
 * int (the goal) and computes the score as described above.
 *)
fun score(card_list, goal) =
    case card_list of
        [] => 0
        | _ =>
            let
                fun prelim_score(n) =
                    if all_same_color(card_list) = true
                    then n div 2
                    else n
                val sum = sum_cards(card_list)
            in
                if sum > goal
                then prelim_score(3 * (sum - goal))
                else prelim_score(goal - sum)
            end


(**
 * (g) Write a function officiate, which "runs a game." It takes a card list
 * (the card-list) a move list (what the player "does" at each point), and an
 * int (the goal) and returns the score at the end of the game after processing
 * (some or all of) the moves in the move list in order. Use a locally defined
 * recursive helper function that takes several arguments that together
 * represent the current state of the game. As described above:
 *
 *   - The game starts with the held-cards being the empty list.
 *   - The game ends if there are no more moves. (The player chose to stop
 *     since the move list is empty.)
 *   - If the player discards some card c, play continues (i.e., make a
 *     recursive call) with the held-cards not having c and the card-list
 *     unchanged. If c is not in the held-cards, raise the IllegalMove
 *     exception.
 *   - If the player draws and the card-list is (already) empty, the game is
 *     over. Else if drawing causes the sum of the held-cards to exceed the
 *     goal, the game is over (after drawing). Else play continues with a
 *     larger held-cards and a smaller card-list.
 *
 * Sample solution for (g) is under 20 lines.
 *)
fun officiate(card_list, move_list, goal) =
    let fun officiate(card_list, move_list, goal, held_cards) =
        case (move_list, card_list) of
            ([], _) => score(held_cards, goal)
            | (m::ms, []) => score(held_cards, goal)
            | (m::ms, c::cs) =>
                case m of
                    Discard c => officiate(c::cs, ms, goal,
                                           remove_card(held_cards, c, IllegalMove))
                    | Draw =>
                        let val sum = sum_cards(c::held_cards)
                        in
                            if sum > goal
                            then score(c::held_cards, goal)
                            else officiate(cs, ms, goal, c::held_cards)
                        end
    in
        officiate(card_list, move_list, goal, [])
    end
