package advent

import "core:os"
import "core:strings"
import "core:unicode"
import "core:fmt"
import "core:strconv"
import "core:slice"

main :: proc() {
	input_data, input_ok := os.read_entire_file("input")
	assert(input_ok)
	input := string(input_data)

	left: [dynamic]int
	right: [dynamic]int

	for l in strings.split_lines_iterator(&input) {
		n1, n2: int
		word_start: int

		for c, ci in l {
			last := ci == len(l) - 1
			
			if !unicode.is_number(c) || last {
				w := l[word_start:last ? ci + 1 : ci]
				word_start = ci + 1
				w_trim := strings.trim_space(w)
				if len(w_trim) > 0 {
					n := strconv.atoi(w_trim)
					if n1 == 0 {
						n1 = n
					} else if n2 == 0 {
						n2 = n
					} else {
						panic("too many numbers on line")
					}
				}
			}
		}

		assert(n1 != 0 && n2 != 0, "failed to fetch two numbers for this line")
		append(&left, n1)
		append(&right, n2)
	}

	right_occurance: map[int]int

	for r in right {
		right_occurance[r] += 1
	}

	total: int
	for l in left {
		m := right_occurance[l]
		v := l * m
		total += v
	}

	fmt.println(total)
}