package advent

import "core:strings"
import "core:strconv"
import "core:fmt"
import "base:runtime"
import "core:slice"

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

			val_first_idx: [99]int
			slice.fill(val_first_idx[:], -1)
			items: [32]int

			idx := 0
			mid: int
			modified := false
			items_num: int

			for input_idx in 0..<num {
				n := strconv.atoi(l[input_idx*3:input_idx*3+2])
				idx := items_num
				must_be_before := rules[n]
				new_idx := idx

				for m in must_be_before {
					maybe_new_idx := val_first_idx[m]
					if maybe_new_idx != -1 && maybe_new_idx < new_idx {
						new_idx = maybe_new_idx
					}
				}

				if new_idx != idx {
					copy(items[new_idx+1:], items[new_idx:])
					modified = true

					for &vfi, val in val_first_idx {
						if vfi >= new_idx {
							vfi += 1
						}
					}
				}

				items[new_idx] = n
				val_first_idx[n] = new_idx

				items_num += 1
			}

			if modified {
				fmt.println(items[:num])
				res += items[num/2]
			}

		}
	}

	fmt.println(res)
}
