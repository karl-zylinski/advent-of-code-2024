package advent

import "core:strings"
import "core:fmt"

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
	input_data := #load("input")
	input := string(input_data)
	li := len(input)
	res: int
	ii := input
	y: int
	
	for l in strings.split_lines_iterator(&ii) {
		ll := l

		for c, x in l {
			if search(x, y, input) {
				res += 1
			}
		}

		y += 1
	}

	fmt.println(res)
}