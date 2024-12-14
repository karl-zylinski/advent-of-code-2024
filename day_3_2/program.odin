package advent

import "core:strconv"
import "core:fmt"
import "base:runtime"

main :: proc() {
	context.allocator = runtime.panic_allocator()
	input_data := #load("input")
	input := string(input_data)
	li := len(input)
	res: int
	idx := 0
	enabled := true

	outer: for idx < li {
		c := input[idx]

		if c == '\n' || c == '\r' {
			idx += 1
			continue
		}

		if input[idx:min(idx+4, li)] == "do()" {
			enabled = true
			idx += 4 
		} else if input[idx:min(idx+7, li)] == "don't()" {
			enabled = false
			idx += 7
		} else if enabled && input[idx:min(idx+4, li)] == "mul(" {
			idx += 4
			n_start := idx
			n1: int
			n2: int

			for ; idx < li; idx += 1 {
				if input[idx] == ',' {
					n1 = strconv.atoi(input[n_start:idx])
					idx += 1
					break
				}

				if input[idx] >= '0' && input[idx] <= '9' { 
					continue
				}

				continue outer
			}

			n_start = idx

			for ; idx < li; idx += 1 {
				if input[idx] == ')' {
					n2 = strconv.atoi(input[n_start:idx])
					idx += 1
					res += n1 * n2
					continue outer
				}

				if input[idx] >= '0' && input[idx] <= '9' { 
					continue
				}

				continue outer
			}
		} else {
			idx += 1
		}
	}

	fmt.println(res) // 95846796
}