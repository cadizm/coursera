
(**
 * Michael Cadiz
 * cadizm (at) 0xfa.de
 * Sat Oct 18 01:21:16 PDT 2014
 *)


(**
 * Write a function is_older that takes two dates and evaluates to true or
 * false. It evaluates to true if the first argument is a date that comes
 * before the second argument. (If the two dates are the same, the result
 * is false.)
 *)
fun is_older (d1 : (int*int*int), d2 : (int*int*int)) =
    if #1 d1 < #1 d2
    then true
    else if #1 d1 > #1 d2
    then false
    else if #2 d1 < #2 d2
    then true
    else if #2 d1 > #2 d2
    then false
    else if #3 d1 < #3 d2
    then true
    else false


(**
 * Write a function number_in_month that takes a list of dates and a month
 * (i.e., an int) and returns how many dates in the list are in the given
 * month.
 *)
fun number_in_month(date_list : (int*int*int) list, month : int) =
    if null date_list
    then 0
    else if #2 (hd date_list) = month
    then 1 + number_in_month((tl date_list), month)
    else number_in_month((tl date_list), month)


(**
 * Write a function number_in_months that takes a list of dates and a list of
 * months (i.e., an int list) and returns the number of dates in the list of
 * dates that are in any of the months in the list of months. Assume the list
 * of months has no number repeated. Hint: Use your answer to the previous
 * problem.
 *)
fun number_in_months(date_list : (int*int*int) list, month_list : int list) =
    if null date_list
    then 0
    else if null month_list
    then 0
    else number_in_month(date_list, (hd month_list)) +
         number_in_months(date_list, (tl month_list))


(**
 * Write a function dates_in_month that takes a list of dates and a month
 * (i.e., an int) and returns a list holding the dates from the argument list
 * of dates that are in the month. The returned list should contain dates in
 * the order they were originally given.
 *)
fun dates_in_month(date_list : (int*int*int) list, month : int) =
    if null date_list
    then []
    else if #2 (hd date_list) = month
    then (hd date_list) :: dates_in_month((tl date_list), month)
    else dates_in_month((tl date_list), month)


(**
 * Write a function dates_in_months that takes a list of dates and a list of
 * months (i.e., an int list) and returns a list holding the dates from the
 * argument list of dates that are in any of the months in the list of months.
 * Assume the list of months has no number repeated. Hint: Use your answer to
 * the previous problem and SML's list-append operator (@).
 *)
fun dates_in_months(date_list : (int*int*int) list, month_list : int list) =
    if null date_list
    then []
    else if null month_list
    then []
    else dates_in_month(date_list, (hd month_list)) @
         dates_in_months(date_list, (tl month_list))


(**
 * Write a function get_nth that takes a list of strings and an int n and
 * returns the nth element of the list where the head of the list is 1st.
 * Do not worry about the case where the list has too few elements: your
 * function may apply hd or tl to the empty list in this case, which is okay.
 *)
fun get_nth(str_list : string list, n : int) =
    let fun get_nth_cur(str_list : string list, n : int, cur : int) =
        if n = cur
        then (hd str_list)
        else get_nth_cur((tl str_list), n, cur+1)
    in
        get_nth_cur(str_list, n, 1)
    end


fun int_get_nth(int_list : int list, n : int) =
    let fun get_nth_cur(int_list : int list, n : int, cur : int) =
        if n = cur
        then (hd int_list)
        else get_nth_cur((tl int_list), n, cur+1)
    in
        get_nth_cur(int_list, n, 1)
    end


(**
 * Write a function date_to_string that takes a date and returns a string of
 * the form January 20, 2013 (for example). Use the operator ^ for
 * concatenating strings and the library function Int.toString for converting
 * an int to a string. For producing the month part, do not use a bunch of
 * conditionals. Instead, use a list holding 12 strings and your answer to the
 * previous problem. For consistency, put a comma following the day and use
 * capitalized English month names: January, February, March, April, May, June,
 * July, August, September, October, November, December.
 *)
fun date_to_string(date : (int*int*int)) =
    get_nth(["January", "February", "March", "April", "May", "June", "July",
             "August", "September", "October", "November", "December"
            ],
            (#2 date)) ^ " " ^ Int.toString((#3 date)) ^ ", " ^
                Int.toString((#1 date))


(**
 * Write a function number_before_reaching_sum that takes an int called sum,
 * which you can assume is positive, and an int list, which you can assume
 * contains all positive numbers, and returns an int. You should return an int
 * n such that the first n elements of the list add to less than sum, but the
 * first n + 1 elements of the list add to sum or more. Assume the entire list
 * sums to more than the passed in value; it is okay for an exception to occur
 * if this is not the case.
 *)
fun number_before_reaching_sum(sum : int, int_list : int list) =
    let fun number_before_reaching_sum_cur(sum : int, int_list : int list,
                                           cur : int, pos : int) =
        if cur + (hd int_list) >= sum
        then pos
        else number_before_reaching_sum_cur(sum, (tl int_list),
                                            cur + (hd int_list), pos+1)
    in
        number_before_reaching_sum_cur(sum, int_list, 0, 0)
    end


(**
 * Write a function what_month that takes a day of year (i.e., an int between
 * 1 and 365) and returns what month that day is in (1 for January, 2 for
 * February, etc.). Use a list holding 12 integers and your answer to the
 * previous problem.
 *)
fun what_month(day_of_year : int) =
    number_before_reaching_sum(day_of_year, [31, 28, 31, 30, 31, 30,
                                             31, 31, 30, 31, 30, 31]) + 1


(**
 * Write a function month_range that takes two days of the year day1 and day2
 * and returns an int list [m1,m2,...,mn] where m1 is the month of day1, m2 is
 * the month of day1+1, ..., and mn is the month of day day2. Note the result
 * will have length day2 - day1 + 1 or length 0 if day1>day2.
 *)
fun month_range(day1 : int, day2 : int) =
    if day1 > day2
    then []
    else let fun month_range_cur(day2 : int, cur : int) =
        if cur = day2
        then [what_month(cur)]
        else [what_month(cur)] @ month_range_cur(day2, cur+1)
    in
        month_range_cur(day2, day1)
    end


(**
 * Write a function oldest that takes a list of dates and evaluates to an
 * (int*int*int) option. It evaluates to NONE if the list has no dates and
 * SOME d if the date d is the oldest date in the list.
 *)
fun oldest(date_list : (int*int*int) list) =
    if null date_list
    then NONE
    else let fun find_oldest(date_list : (int*int*int) list) =
        if null (tl date_list) (* date_list must not be [] *)
        then (hd date_list)
        else let val tl_ans = find_oldest(tl date_list)
        in
            if is_older((hd date_list), tl_ans)
            then (hd date_list)
            else tl_ans
        end
    in
        SOME (find_oldest(date_list))
    end


(**
 * Return true if int haystack contains int needle, false otherwise
 *)
fun contains(needle : int, haystack : int list) =
    if null haystack
    then false
    else if (hd haystack) = needle
    then true
    else contains(needle, (tl haystack))


(**
 * Return haystack with needle removed
 *)
fun remove(needle : int, haystack : int list) =
    if null haystack
    then []
    else if (hd haystack) = needle
    then remove(needle, tl haystack)
    else [hd haystack] @ remove(needle, tl haystack)


(**
 * Remove duplicates from int list int_list (non stable version)
 *)
fun unique(int_list : int list) =
    if null int_list
    then []
    else if not(contains(hd int_list, tl int_list))
    then [hd int_list] @ unique(tl int_list)
    else unique(tl int_list)


(**
 * Remove duplicates from int list int_list (stable version)
 *)
fun stable_unique(int_list : int list) =
    if null int_list
    then []
    else if contains(hd int_list, tl int_list)
    then let val removed_int_list = remove(hd int_list, tl int_list)
    in
        [hd int_list] @ stable_unique(removed_int_list)
    end
    else [hd int_list] @ stable_unique(tl int_list)


(**
 * Challenge Problem: Write functions number_in_months_challenge and
 * dates_in_months_challenge that are like your solutions to problems 3 and
 * 5 except having a month in the second argument multiple times has no more
 * effect than having it once. (Hint: Remove duplicates, then use previous
 * work.)
 *)
fun number_in_months_challenge(date_list : (int*int*int) list,
                               month_list : int list) =
    if null date_list
    then 0
    else if null month_list
    then 0
    else let val unique_month_list = unique(month_list)
    in
        number_in_month(date_list, (hd unique_month_list)) +
        number_in_months_challenge(date_list, (tl unique_month_list))
    end


(**
 * Challenge Problem: Write functions number_in_months_challenge and
 * dates_in_months_challenge that are like your solutions to problems 3 and
 * 5 except having a month in the second argument multiple times has no more
 * effect than having it once. (Hint: Remove duplicates, then use previous
 * work.)
 *)
fun dates_in_months_challenge(date_list : (int*int*int) list,
                              month_list : int list) =
    if null date_list
    then []
    else if null month_list
    then []
    else let val unique_month_list = stable_unique(month_list)
    in
        dates_in_month(date_list, (hd unique_month_list)) @
        dates_in_months_challenge(date_list, (tl unique_month_list))
    end


(**
 * Return true if year is a leap year.
 * Leap years are years that are either divisible by 400 or divisible by 4 but
 * not divisible by 100.
 *)
fun is_leap_year(year : int) =
    (year mod 400 = 0 orelse year mod 4 = 0) andalso year mod 100 <> 0


(**
 * Return number of calendar days in the given month, taking leap years into
 * consideration. 0 if not a valid month
 *)
fun num_days_in_month(month : int, year : int) =
    if month < 1 orelse month > 12
    then 0
    else let val num_days = int_get_nth([31, 28, 31, 30, 31, 30,
                                         31, 31, 30, 31, 30, 31],
                                        month)
    in
        if is_leap_year(year) andalso month = 2
        then
            num_days + 1
        else
            num_days
    end


(**
 * Return true if day is within the calendar days of month, taking leap years
 * into consideration. False otherwise.
 *)
fun valid_day_month(day : int, month : int, year : int) =
    if day >= 1 andalso day <= num_days_in_month(month, year)
    then true
    else false


(**
 * Challenge Problem: Write a function reasonable_date that takes a date and
 * determines if it describes a real date in the common era. A "real date" has
 * a positive year (year 0 did not exist), a month between 1 and 12, and a day
 * appropriate for the month. Solutions should properly handle leap years. Leap
 * years are years that are either divisible by 400 or divisible by 4 but not
 * divisible by 100. (Do not worry about days possibly lost in the conversion
 * to the Gregorian calendar in the Late 1500s.)
 *)
fun reasonable_date(date : (int*int*int)) =
    let val year = #1 date val month = #2 date val day = #3 date
    in
        if year > 0 andalso month >= 1 andalso month <= 12 andalso
            valid_day_month(day, month, year)
        then true
        else false
    end
