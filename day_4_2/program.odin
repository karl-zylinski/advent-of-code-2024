package advent

import "core:fmt"
import "base:runtime"

w :: 141
h :: 141

search :: proc(x: int, y: int, s: string) -> bool {
	get_char :: proc(x: int, y: int, s: string) -> u8 {
		if x < 0 || x >= 140 || y < 0 || y >= 140 {
			return 0
		}

		return s[y * w + x]
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
	input := string(input_data)
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