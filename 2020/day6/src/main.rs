use itertools::Itertools;
use std::iter::FromIterator;

fn main() {
    let filename = "input6.txt";

    let contents = slurp::read_all_to_string(filename).unwrap();

    let splits = contents.split_terminator("\n\n");

    let mut sum1 = 0;

    for s in splits {
        let d = s.replace("\n", "");
        sum1 += d.as_bytes().into_iter().unique().count();
    }

    let splits = contents.split_terminator("\n\n");

    let mut sum2 = 0;

    for string in splits {
        let persons = string.matches("\n").count()+1;
        let mut answers:Vec<char> = string.replace("\n", "").chars().collect();
        answers.sort();
        let sorted_answers = String::from_iter(answers);

        let mut group_sum = 0;
        for (_key, group) in &sorted_answers.as_bytes().into_iter().group_by(|a| *a) {
            let answers_count = group.count();
            // println!("{}: {} -> {}", persons, std::str::from_utf8(&[*_key]).unwrap(), answers_count);

            if answers_count == persons {
                group_sum += 1;
            };
        }

        // println!("{}, {}", sorted_answers, group_sum);

        sum2 += group_sum;
    }

    println!("Part 1: {}", sum1);
    println!("Part 2: {}", sum2);
}
