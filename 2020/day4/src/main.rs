use regex::Regex;

fn parse<'a>(re: &Regex, string: &'a &String) -> &'a str {
    return re.captures(string).unwrap().get(1).unwrap().as_str();
}

fn main() {
    let filename = "input4.txt";
    // let filename = "input4_small.txt";
    // let filename = "invalid.txt";
    // let filename = "valid.txt";

    let contents = slurp::read_all_to_string(filename).unwrap();

    let splits = contents.split_terminator("\n\n");

    let mut valid_passports1 = 0;
    for s in splits {
        let d = s.replace("\n", " ");
        if d.contains("byr:") && d.contains("iyr:") && d.contains("eyr:") && d.contains("hgt:") && d.contains("hcl:") && d.contains("ecl:") && d.contains("pid:") {
            valid_passports1 += 1;
        }
    }

    let mut valid_passports2 = 0;
    let byr_re = Regex::new(r"byr:(\d{4}) ").unwrap();
    let iyr_re = Regex::new(r"iyr:(\d{4}) ").unwrap();
    let eyr_re = Regex::new(r"eyr:(\d{4}) ").unwrap();
    let hgt_re = Regex::new(r"hgt:(1([5-8][0-9]|9[0-3])cm |(59|6[0-9]|7[0-6])in )").unwrap();
    let hcl_re = Regex::new(r"hcl:#([0-9a-f]{6}) ").unwrap();
    let ecl_re = Regex::new(r"ecl:(amb|blu|brn|gry|grn|hzl|oth) ").unwrap();
    let pid_re = Regex::new(r"pid:([0-9]{9}) ").unwrap();

    let splits = contents.split_terminator("\n\n");

    for s in splits {
        let d = s.replace("\n", " ");
        let a = format!("{} ", d);
        if byr_re.is_match(&a) && iyr_re.is_match(&a) && eyr_re.is_match(&a) && hgt_re.is_match(&a) && hcl_re.is_match(&a) && ecl_re.is_match(&a) && pid_re.is_match(&a) {
            let byr: usize = parse(&byr_re, &(&a)).parse().unwrap();
            let iyr: usize = parse(&iyr_re, &(&a)).parse().unwrap();
            let eyr: usize = parse(&eyr_re, &(&a)).parse().unwrap();

            if byr >= 1920 && byr <= 2002 && iyr >= 2010 && iyr <= 2020 && eyr >= 2020 && eyr <= 2030 {
                valid_passports2 = valid_passports2 + 1;
            }
        }
    }

    println!("Part 1: {}", valid_passports1);
    println!("Part 2: {}", valid_passports2);
}
