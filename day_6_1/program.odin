package advent

import "core:fmt"
import "base:runtime"

main :: proc() {
	context.allocator = runtime.panic_allocator()
	context.temp_allocator = runtime.panic_allocator()

	input_data := #load("input")
	input := string(input_data)

	Vec2 :: [2]int
	w :: 130
	h :: 130

	Cell_Type :: enum {
		Empty,
		Blocked,
		Visited,
	}

	grid: [w * h]Cell_Type
	pos: Vec2
	dir := Vec2 {0, -1}

	idx: int
	for s in input {
		if s == '#' {
			grid[idx] = .Blocked
		}

		if s == '^' {
			grid[idx] = .Visited
			pos = {idx % w, idx / h}
		}

		if s != '\r' && s != '\n' {
			idx += 1
		}
	}

	res := 1

	for {
		new_pos := pos + dir

		if new_pos.x < 0 || new_pos.x >= w || new_pos.y < 0 || new_pos.y >= h {
			break
		}

		grid_idx := new_pos.y * w + new_pos.x	
		
		if grid[grid_idx] == .Blocked {
			dir = {-dir.y, dir.x}
		} else {
			pos = new_pos

			if grid[grid_idx] != .Visited {
				grid[grid_idx] = .Visited
				res += 1
			}
		}
	}

	fmt.println(res)
}
