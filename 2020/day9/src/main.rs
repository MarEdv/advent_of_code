use std::collections::HashSet;

fn main() {
    let filename = "input9.txt";
    let window_size = 25;

    let numbers: Vec<i64> = slurp::read_all_lines(filename).unwrap()
        .iter().map(|l| l.parse().unwrap())
        .collect();

    let mut i = window_size;
    'outer: loop {
        if i > numbers.len() {
            break 'outer;
        }

        let value = numbers.get(i).unwrap();

        let mut is_found = false;

        'inner: for x in i-window_size..i-1 {
            for y in x+1..i {
                if *numbers.get(x).unwrap() + *numbers.get(y).unwrap() == *value {
                    is_found = true;
                    break 'inner;
                }
            }
        }

        if !is_found {
            break 'outer;
        }
        i += 1;
    }

    let part1 = numbers.get(i).unwrap();
    println!("Part 1: (idx = {}) {}", i, part1);

    let mut part2 = (0,0);

    'outer2: for x in 0..numbers.len()-1 {
        let mut sum = 0;
        let mut values:HashSet<i64> = HashSet::new();

        'inner2: for y in x+1..numbers.len() {
            let value = *numbers.get(y).unwrap();
            values.insert(value);
            sum += value;
            if sum > *part1 {
                break 'inner2;
            }
            if sum == *part1 {
                let min = values.iter().min_by(|a,b|a.cmp(b));
                let max = values.iter().max_by(|a,b|a.cmp(b));
                part2 = (*min.unwrap(), *max.unwrap());
                break 'outer2;
            }
        }
    }

    let (min, max) = part2;

    println!("Part 2: ({} + {}) {}", min, max, (min + max));
}
