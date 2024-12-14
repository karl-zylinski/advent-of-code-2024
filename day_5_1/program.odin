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
	seen_list: [dynamic]int

	outer: for l in strings.split_lines_iterator(&ii) {
		if l == "" {
			processing_rules = false
			continue
		}

		if processing_rules {
			key, val: int

			ll := l
			ci: int
			for ns in strings.split_iterator(&ll, "|") {
				if ci == 0 {
					key = strconv.atoi(ns)
				} else if ci == 1 {
					val = strconv.atoi(ns)
				} else {
					panic("too many things on rule line")
				}
				ci += 1
			}

			assert(key != 0 && val != 0)
			r := &rules[key]
			if r == nil {
				rules[key] = {}
				r = &rules[key]
			}
			r^ += {val}
			fmt.println(r^)
		} else {
			ll := l
			seen = {}
			clear(&seen_list)
			for ns in strings.split_iterator(&ll, ",") {
				n := strconv.atoi(ns)

				if rules[n] & seen != {} {
					continue outer
				}

				seen += {n}
				append(&seen_list, n)
			}

			res += seen_list[len(seen_list)/2]
		}
	}

	fmt.println(res) // 5651
}