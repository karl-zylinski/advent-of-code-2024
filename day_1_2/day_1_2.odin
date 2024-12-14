package advent

import "core:strings"
import "core:fmt"
import "core:strconv"
import "base:runtime"

right_occurance: [99999]int

main :: proc() {
	context.allocator = runtime.panic_allocator()
	input_data := #load("input")
	input := string(input_data)

	for line in strings.split_lines_iterator(&input) {
		r := strconv.atoi(line[8:])
		right_occurance[r] += 1
	}

	input = string(input_data)
	total: int

	for line in strings.split_lines_iterator(&input) {
		l := strconv.atoi(line[:6])
		total += l * right_occurance[l]
	}

	fmt.println(total) // 21142653
}