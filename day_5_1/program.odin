package advent

import "core:strings"
import "core:strconv"
import "core:fmt"
import "core:slice"

main :: proc() {
	input_data := #load("input")
	input := string(input_data)
	res: int

	processing_rules := true
	ii := input

	Num_Set :: bit_set[0..=99;u128]

	rules: map[int]Num_Set
	seen: Num_Set

	outer: for l in strings.split_lines_iterator(&ii) {
		if l == "" {
			processing_rules = false
			continue
		}

		if processing_rules {
			key, val: int
			ll := l

			for ns in strings.split_iterator(&ll, "|") {
				if key == 0 {
					key = strconv.atoi(ns)
				} else if val == 0 {
					val = strconv.atoi(ns)
				} else {
					panic("too many things on rule line")
				}
			}

			assert(key != 0 && val != 0)
			r := &rules[key]
			if r == nil {
				rules[key] = {}
				r = &rules[key]
			}
			r^ += {val}
		} else {
			ll := l
			seen = {}
			num := strings.count(ll, ",") + 1
			nsi: int
			mid: int
			for ns in strings.split_iterator(&ll, ",") {
				n := strconv.atoi(ns)
				if nsi == num/2 {
					mid = n
				}

				if rules[n] & seen != {} {
					continue outer
				}

				seen += {n}
				nsi += 1
			}

			res += mid
		}
	}

	fmt.println(res) // 5651
}