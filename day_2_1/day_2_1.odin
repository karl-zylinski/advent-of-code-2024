package advent

import "core:os"
import "core:strings"
import "core:strconv"
import "core:fmt"
import "base:runtime"

main :: proc() {
	context.allocator = runtime.panic_allocator()
	input_data := #load("input")
	input := string(input_data)
	num_safe: int

	outer: for lo in strings.split_lines_iterator(&input) {
		prev: int
		dir: int

		l := lo
		for n_str in strings.split_iterator(&l, " ") {
			n := strconv.atoi(n_str)

			if prev == 0 {
				prev = n
				continue
			}

			diff := prev - n

			if abs(diff) < 1 || abs(diff) > 3 {
				continue outer
			}

			cur_dir := diff > 0 ? 1 : -1

			if dir == 0 {
				dir = cur_dir
			} else {
				if dir != cur_dir {
					continue outer
				}
			}

			prev = n
		}

		num_safe += 1
	}

	fmt.println(num_safe)
}