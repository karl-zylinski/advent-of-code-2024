package advent

import "core:strings"
import "core:strconv"
import "core:fmt"

main :: proc() {
	input_data := #load("input")
	input := string(input_data)
	res: int
	Num_Set :: bit_set[0..=99;u128]
	rules: map[int]Num_Set
	processing_rules := true

	outer: for lo in strings.split_lines_iterator(&input) {
		l := lo

		if l == "" {
			processing_rules = false
			continue
		}

		if processing_rules {
			key := strconv.atoi(l[:2])
			val := strconv.atoi(l[3:])
			rules[key] += {val}
		} else {
			seen: Num_Set
			num := (len(l)-2)/3+1
			idx: int
			mid: int

			for n_str in strings.split_iterator(&l, ",") {
				n := strconv.atoi(n_str)

				if idx == num/2 {
					mid = n
				}

				if rules[n] & seen != {} {
					continue outer
				}

				seen += {n}
				idx += 1
			}

			res += mid
		}
	}

	fmt.println(res) // 5651
}