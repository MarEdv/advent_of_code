use std::collections::HashMap;
use regex::Regex;
use std::collections::HashSet;

#[derive(Hash, Eq, PartialEq, Debug)]
struct BagDefinition {
    count: usize,
    name: String
}

fn can_carry_golden_bag(key: &str, rules: &HashMap<&str, HashSet<BagDefinition>>) -> bool {
    let definitions = rules.get(key).unwrap();
    let e: Vec<&BagDefinition> = definitions.iter().filter(|d|
        {
            if d.name == "shiny gold" {
                return true;
            } else {
                return can_carry_golden_bag(d.name.as_str(), rules)
            }
    })
    .collect();
    return e.len() > 0;
}

fn count_golden_bag_contents(key: &str, rules: &HashMap<&str, HashSet<BagDefinition>>) -> usize {
    let definitions = rules.get(key).unwrap();
    let e: Vec<usize> = definitions.iter()
        .map(|d| d.count * (1 + count_golden_bag_contents(d.name.as_str(), rules)))
        .collect();
    let sum = e.iter().fold(0, |acc, item| acc + item);

    return sum;
}

fn main() {
    let filename = "input7.txt";
    let lines = slurp::read_all_lines(filename).unwrap();

    let re = Regex::new(r"(.* .*) bags? contain").unwrap();
    let re2 = Regex::new(r"(,?\d+ [a-z]+ [a-z]+ bags?)+.").unwrap();
    let re3 = Regex::new(r"no other bags\.").unwrap();
    let re4 = Regex::new(r"(\d)+ ([a-z]+ [a-z]+) bags?").unwrap();
    
    let mut rules = HashMap::new();

    for line in lines.iter() {
        let m = re.captures(line).unwrap();
        let rule = m.get(1).unwrap();

        let y: HashSet<BagDefinition> = re2.find_iter(line)
            .map(|m| m.as_str())
            .filter(|s| !re3.is_match(s))
            .map(|s| {
                let u = re4.captures(s).unwrap();
                return BagDefinition{count: u.get(1).unwrap().as_str().parse().unwrap(), name: u.get(2).unwrap().as_str().to_string()}
            })
            .collect();

        rules.insert(rule.as_str(), y);
    }

    let result: Vec<String> = rules.keys()
        .map(|k| k.to_string())
        .filter(|key| can_carry_golden_bag(key, &rules))
        .collect();

    let count2 = count_golden_bag_contents("shiny gold", &rules);

    println!("Part 1: {}", result.len());
    println!("Part 2: {}", count2);
}
