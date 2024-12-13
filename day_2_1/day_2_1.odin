package advent

import "core:os"
import "core:strings"
import "core:strconv"
import "core:fmt"

main :: proc() {
	input_data, input_ok := os.read_entire_file("input")
	assert(input_ok)
	input := string(input_data)

	num_safe: int

	for l in strings.split_lines_iterator(&input) {
		prev: int
		first := true
		safe := true
		dir: int
		seen_one_bad := false

		ll := l
		for ns in strings.split_iterator(&ll, " ") {
			n := strconv.atoi(ns)

			if first {
				prev = n
				first = false
				continue
			}

			diff := prev - n
			bad := false

			if abs(diff) < 1 || abs(diff) > 3 {
				bad = true
			}

			cur_dir := diff > 0 ? 1 : -1

			if dir == 0 {
				dir = cur_dir
			} else {
				if dir != cur_dir {
					bad = true
				}
			}

			if bad {
				if !seen_one_bad {
					seen_one_bad = true
					continue
				} else {
					safe = false
					break
				}
			}

			prev = n
		}

		if safe {
			num_safe += 1
		}
	}

	fmt.println(num_safe)
}