package advent

import "core:strings"
import "core:strconv"
import "core:fmt"
import "base:runtime"
import "core:slice"

// THIS IS WIP AND DOES NOT WORK

main :: proc() {
	context.allocator = runtime.panic_allocator()
	input_data := #load("input")
	input := string(input_data)
	res: int
	Num_Set :: bit_set[0..=99]
	rules: [99]Num_Set
	processing_rules := true

	lines_iterator := input
	outer: for l in strings.split_lines_iterator(&lines_iterator) {
		if l == "" {
			processing_rules = false
			continue
		}

		if processing_rules {
			key := strconv.atoi(l[:2])
			val := strconv.atoi(l[3:])
			rules[key] += {val}
		} else {
			num := (len(l)-2)/3+1
			items: [32]int
			seen: Num_Set


			for idx in 0..<num {
				items[idx] = strconv.atoi(l[idx*3:idx*3+2])
				seen += { items[idx] }
			}

			idx := num - 1
			mid: int

			for ; idx >= 0; idx -= 1 {
				n := items[idx]

				if idx == num/2 {
					mid = n
				}

				if rules[n] & seen != {} {
					slice.swap(items[:], idx - 1, idx)
					seen -= {items[idx]}
					continue
				}

				seen += {n}
			}


			fmt.println(items)

			res += mid
		}
	}

	fmt.println(res)
}