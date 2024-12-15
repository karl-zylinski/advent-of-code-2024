package advent

import "core:fmt"
import "base:runtime"

w :: 140
h :: 140

search :: proc(x: int, y: int, s: string) -> int {
	get_char :: proc(x: int, y: int, s: string) -> u8 {
		if x >= 0 && x < w && y >= 0 && y < h {
			return s[y * w + x]
		}

		return 0
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
			res += search(x, y, input)
		}
	}

	fmt.println(res)
}