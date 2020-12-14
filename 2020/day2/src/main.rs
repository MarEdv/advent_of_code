use std::fs::File;
use std::io::{BufRead, BufReader};

#[derive(Clone)]
struct PasswordRule {
    min: usize,
    max: usize,
    character: String,
    password: String
}

fn main() {
    let filename = "input2.txt";

    let file = File::open(filename).unwrap();
    let reader = BufReader::new(file);

    let mut v = Vec::new();
    for (_index, line) in reader.lines().enumerate() {
        let re = regex::Regex::new(r"[-\s:]+").unwrap();
        let items: Vec<String> = re.split(&line.unwrap()).map(|x| { x.to_string() }).collect::<Vec<_>>();

        v.push(PasswordRule { 
            min: items[0].parse().unwrap(),
            max: items[1].parse().unwrap(),
            character: items[2].to_string(),
            password: items[3].to_string(),
        });
    }

    let rules1: Vec<_> = v.iter().cloned()
        .filter(|rule| {
            let l = rule.password.split("")
                .map(|c| { c.to_string() })
                .filter(|c| {
                    c == &rule.character
                })
                .collect::<String>()
                .len();
            l <= rule.max && l >= rule.min
        })
        .collect();
    println!("Part 1: {}", rules1.len());

    let rules2: Vec<_> = v.iter().cloned()
        .filter(|rule| {
            let c = rule.character.chars().nth(0).unwrap();
            let cs = rule.password.chars().nth(rule.max-1).unwrap();
            let cs2 = rule.password.chars().nth(rule.min-1).unwrap();

            cs == c && cs2 != c || cs != c && cs2 == c
        })
        .collect();
    println!("Part 2: {}", rules2.len());
}