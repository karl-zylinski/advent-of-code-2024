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

	left: [1000]u32
	right: [1000]u32
	idx: int

	for l in strings.split_lines_iterator(&input) {
		left[idx] = u32(strconv.atoi(l[:6]))
		right[idx] = u32(strconv.atoi(l[8:]))
		idx += 1
	}

	slice.sort(left[:])
	slice.sort(right[:])
	total: int

	for i in 0..<len(left) {
		d := abs(int(right[i])-int(left[i]))
		total += d
	}

	fmt.println(total)
}