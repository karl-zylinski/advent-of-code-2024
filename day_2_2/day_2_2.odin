package advent

import "core:strings"
import "core:strconv"
import "core:fmt"
import "base:runtime"

main :: proc() {
	context.allocator = runtime.panic_allocator()
	input_data := #load("input")
	input := string(input_data)
	num_safe: int
	nums: [10]int

	outer: for l in strings.split_lines_iterator(&input) {
		ll := l
		nums_len: int

		for ns in strings.split_iterator(&ll, " ") {
			nums[nums_len] = strconv.atoi(ns)
			nums_len += 1
		}

		prev: int
		dir: int
		skip_idx := -1
		i: int

		for i < nums_len {
			if skip_idx == i {
				i += 1
				continue
			}

			n := nums[i]

			if prev == 0 {
				prev = n
				i += 1
				continue
			}

			diff := n - prev
			prev = n
			bad := false

			if abs(diff) < 1 || abs(diff) > 3 {
				bad = true
			}

			cur_dir := diff > 0 ? 1 : -1

			if dir == 0 {
				dir = cur_dir
			} else if dir != cur_dir {
				bad = true
			}

			if bad {
				if skip_idx < len(nums) {
					i = 0
					prev = 0
					dir = 0
					skip_idx += 1
					continue
				}

				continue outer
			}

			i += 1
		}

		num_safe += 1
	}

	fmt.println(num_safe) // 398
}