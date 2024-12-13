package advent

import "core:strings"
import "core:fmt"

w :: 141
h :: 141

Dir :: enum {
	N, NE, E, SE, S, SW, W, NW,
}

search :: proc(x: int, y: int, s: string) -> int {
	get_char :: proc(x: int, y: int, s: string) -> u8 {
		if x < 0 || x >= 140 || y < 0 || y >= 140 {
			return 0
		}

		return s[y * w + x]
	}

	xmas := "XMAS"

	res := 8

	fail: [Dir]bool

	for i in 0..<len(xmas) {
		if !fail[.N] && get_char(x, y - i, s) != xmas[i] {
			res -= 1
			fail[.N] = true
		}

		if !fail[.NE] && get_char(x + i, y - i, s) != xmas[i] {
			res -= 1
			fail[.NE] = true
		}

		if !fail[.E] && get_char(x + i, y, s) != xmas[i] {
			res -= 1
			fail[.E] = true
		}

		if !fail[.SE] && get_char(x + i, y + i, s) != xmas[i] {
			res -= 1
			fail[.SE] = true
		}

		if !fail[.S] && get_char(x, y + i, s) != xmas[i] {
			res -= 1
			fail[.S] = true
		}

		if !fail[.SW] && get_char(x - i, y + i, s) != xmas[i] {
			res -= 1
			fail[.SW] = true
		}

		if !fail[.W] && get_char(x - i, y, s) != xmas[i] {
			res -= 1
			fail[.W] = true
		}

		if !fail[.NW] && get_char(x - i, y - i, s) != xmas[i] {
			res -= 1
			fail[.NW] = true
		}

	}

	return res
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
			res += search(x, y, input)
		}

		y += 1
	}

	fmt.println(res)
}