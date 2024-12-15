package advent

import "core:fmt"
import "base:runtime"

w :: 140
h :: 140

search :: proc(x: int, y: int, s: string) -> bool {
	get_char :: proc(x: int, y: int, s: string) -> u8 {
		if x >= 0 && x < w && y >= 0 && y < h {
			return s[y * w + x]
		}

		return 0
	}

	if get_char(x, y, s) != 'A' {
		return false
	}

	tl := get_char(x - 1, y - 1, s)
	tr := get_char(x + 1, y - 1, s)
	bl := get_char(x - 1, y + 1, s)
	br := get_char(x + 1, y + 1, s)

	return ((tl == 'M' && br == 'S') || (tl == 'S' && br == 'M')) &&
		   ((tr == 'M' && bl == 'S') || (tr == 'S' && bl == 'M'))
}

main :: proc() {
	context.allocator = runtime.panic_allocator()
	input_data := #load("input")
	raw_input := string(input_data)
	proceseed_input: [w*h]u8
	idx: int

	// Remove all those line breaks that ruin my life when I try to index this
	// using coordinates.
	for input_idx in 0..<len(raw_input) {
		if raw_input[input_idx] == '\n' || raw_input[input_idx] == '\r' {
			continue
		}

		proceseed_input[idx] = raw_input[input_idx]
		idx += 1
	}

	input := string(proceseed_input[:])
	res: int
	
	for x in 0..<w {
		for y in 0..<h {
			if search(x, y, input) {
				res += 1
			}
		}
	}

	fmt.println(res)
}