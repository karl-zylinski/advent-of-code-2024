package advent

import "core:os"
import "core:strings"
import "core:strconv"
import "core:fmt"
import "core:unicode"

main :: proc() {
	input_data, input_ok := os.read_entire_file("input")
	assert(input_ok)
	input := string(input_data)

	res: int

	idx := 0

	outer: for idx < len(input) {
		c := input[idx]

		if c == '\n' || c == '\r' {
			idx += 1
			continue
		}

		if idx + 4 < len(input) && input[idx:idx+4] == "mul(" {
			idx += 4
			n_start := idx
			n1: int
			n2: int

			for ; idx < len(input); idx += 1 {
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

			for ; idx < len(input); idx += 1 {
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
		}

		idx += 1
	}

	fmt.println(res)
}