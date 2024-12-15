package advent

import "core:strings"
import "core:strconv"
import "core:fmt"
import "base:runtime"
import "core:slice"

main :: proc() {
	context.allocator = runtime.panic_allocator()
	context.temp_allocator = runtime.panic_allocator()

	input_data := #load("input")
	input := string(input_data)
	Num_Set :: bit_set[0..=99]
	rules: [99]Num_Set
	item_to_idx: [99]int
	items: [32]int
	processing_rules := true
	res: int

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
			slice.fill(item_to_idx[:], -1)
			needed_reordering := false
			items_num: int

			for input_idx in 0..<num {
				n := strconv.atoi(l[input_idx*3:input_idx*3+2])
				idx := items_num
				must_be_before_set := rules[n]
				new_idx := idx

				for m in must_be_before_set {
					maybe_new_idx := item_to_idx[m]
					if maybe_new_idx != -1 && maybe_new_idx < new_idx {
						new_idx = maybe_new_idx
					}
				}

				if new_idx != idx {
					copy(items[new_idx+1:], items[new_idx:])

					for &vfi in item_to_idx {
						if vfi >= new_idx {
							vfi += 1
						}
					}

					needed_reordering = true
				}

				items[new_idx] = n
				item_to_idx[n] = new_idx
				items_num += 1
			}

			if needed_reordering {
				res += items[num/2]
			}
		}
	}

	fmt.println(res)
}
