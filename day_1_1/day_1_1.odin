package advent

import "core:strings"
import "core:fmt"
import "core:strconv"
import "core:slice"
import "base:runtime"

main :: proc() {
	context.allocator = runtime.panic_allocator()
	input_data := #load("input")
	input := string(input_data)

	left: [1000]int
	right: [1000]int
	idx: int

	for l in strings.split_lines_iterator(&input) {
		left[idx] = strconv.atoi(l[:6])
		right[idx] = strconv.atoi(l[8:])
		idx += 1
	}

	slice.sort(left[:])
	slice.sort(right[:])
	total: int

	for i in 0..<len(left) {
		l := left[i]
		r := right[i]
		d := abs(r-l)
		total += d
	}

	fmt.println(total)
}