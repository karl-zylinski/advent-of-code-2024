package advent

import "core:fmt"
import "base:runtime"

w :: 141
h :: 141

search :: proc(x: int, y: int, s: string) -> int {
	get_char :: proc(x: int, y: int, s: string) -> u8 {
		if x < 0 || x >= 140 || y < 0 || y >= 140 {
			return 0
		}

		return s[y * w + x]
	}

	xmas := "XMAS"
	res := 8

	Dir :: enum {
		N, NE, E, SE, S, SW, W, NW,
	}

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
	context.allocator = runtime.panic_allocator()
	input_data := #load("input")
	input := string(input_data)
	res: int
	
	for x in 0..<w {
		for y in 0..<h {
			res += search(x, y, input)
		}
	}

	fmt.println(res)
}