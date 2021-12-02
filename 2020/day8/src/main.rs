use std::collections::HashSet;

fn main() {
    let filename = "input8.txt";
    let lines = slurp::read_all_lines(filename).unwrap();

    let mut idx: usize = 0;
    let mut visited_idxs: HashSet<usize> = HashSet::new();

    let mut value:i32 = 0;
    loop {
        let line = lines.get(idx).unwrap();
        if visited_idxs.contains(&idx) {
            break;
        }

        visited_idxs.insert(idx);

        if line.starts_with("acc") {
            if line.chars().nth(4).unwrap() == '+' {
                let a: i32 = line[5..].to_string().parse().unwrap();
                value += a;
            } else {
                let a: i32 = line[5..].to_string().parse().unwrap();
                value -= a;
            }
            idx += 1;
        } else if line.starts_with("jmp") {
            if line.chars().nth(4).unwrap() == '+' {
                let a: usize = line[5..].to_string().parse().unwrap();
                idx += a;
            } else {
                let a: usize = line[5..].to_string().parse().unwrap();
                idx -= a;
            }
        } else {
            idx += 1;
        }
    }

    println!("Part 1: {}", value);

    let h = lines.clone();
    let jmp_nops: Vec<&String> = h.iter().filter(|x| x.starts_with("nop") || x.starts_with("jmp")).collect();
    let mut jmp_nops_count = jmp_nops.len();
    let real_value;

    loop {
        let mut what_jmp_nop: i32 = jmp_nops_count as i32;
        let mut idx: usize = 0;
        let mut visited_idxs: HashSet<usize> = HashSet::new();

        let mut value:i32 = 0;

        println!("{}", what_jmp_nop);
        loop {
            if visited_idxs.contains(&idx) || idx >= lines.len() {
                break;
            }
            let line = lines.get(idx).unwrap();

            visited_idxs.insert(idx);

            if line.starts_with("acc") {
                if line.chars().nth(4).unwrap() == '+' {
                    let a: i32 = line[5..].to_string().parse().unwrap();
                    value += a;
                } else {
                    let a: i32 = line[5..].to_string().parse().unwrap();
                    value -= a;
                }
                idx += 1;
            } else if line.starts_with("jmp") {
                what_jmp_nop -= 1;
                if what_jmp_nop != 0 {
                    if line.chars().nth(4).unwrap() == '+' {
                        let a: usize = line[5..].to_string().parse().unwrap();
                        idx += a;
                    } else {
                        let a: usize = line[5..].to_string().parse().unwrap();
                        idx -= a;
                    }
                } else {
                    idx += 1;
                }
            } else {
                what_jmp_nop -= 1;
                if what_jmp_nop == 0 {
                    if line.chars().nth(4).unwrap() == '+' {
                        let a: usize = line[5..].to_string().parse().unwrap();
                        idx += a;
                    } else {
                        let a: usize = line[5..].to_string().parse().unwrap();
                        idx -= a;
                    }
                } else {
                    idx += 1;
                }
            }
        }

        if idx >= lines.len() {
            real_value = value;
            println!("Exit {}", what_jmp_nop);
            break;
        }
        jmp_nops_count -= 1;
    }

    println!("Part 2: {}", real_value);
}
