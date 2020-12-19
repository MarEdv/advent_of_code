//use regex::Regex;
use std::vec::Vec;

fn main() {
    let filename = "input5.txt";

    let lines = slurp::read_all_lines(filename).unwrap();

    let mut max:usize = 0;
    let mut boarding_pass_ids: Vec<usize> = Vec::new();

    for boarding_pass in lines.iter() {
        let binary_boarding_pass = boarding_pass.replace("F", "0").replace("B", "1").replace("L", "0").replace("R", "1");
        let boarding_pass_id = usize::from_str_radix(&binary_boarding_pass, 2).unwrap();

        boarding_pass_ids.push(boarding_pass_id);

        if boarding_pass_id > max {
            max = boarding_pass_id;
        }
    }

    boarding_pass_ids.sort();

    let mut missing = 0;

    for boarding_pass_id in *boarding_pass_ids.first().unwrap()..*boarding_pass_ids.last().unwrap() {
        if !boarding_pass_ids.contains(&boarding_pass_id) {
            missing = boarding_pass_id;
        }
    }

    println!("Part 1: {}", max);
    println!("Part 2: {}", missing);
}
