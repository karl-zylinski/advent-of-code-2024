package advent

import "core:os"
import "core:strings"
import "core:strconv"
import "core:fmt"

check_line :: proc(nums: []int) -> bool {
	prev: int
	dir: int
	skip_idx := -1

	i: int

	for i < len(nums) {
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

			return false
		}

		i += 1
	}

	return true
}

main :: proc() {
	input_data, input_ok := os.read_entire_file("input")
	assert(input_ok)
	input := string(input_data)

	num_safe: int

	nums: [10]int

	for l in strings.split_lines_iterator(&input) {
		ll := l
		n: int

		for ns in strings.split_iterator(&ll, " ") {
			nums[n] = strconv.atoi(ns)
			n += 1
		}

		if check_line(nums[:n]) {
			num_safe += 1
		}
	}

	fmt.println(num_safe)
}