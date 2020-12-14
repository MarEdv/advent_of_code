use std::fs::File;
use std::io::{BufRead, BufReader};

fn main() {
    let filename = "input1.txt";

    let file = File::open(filename).unwrap();
    let reader = BufReader::new(file);

    let mut v = Vec::new();
    for (_index, line) in reader.lines().enumerate() {
        v.push(line.unwrap());
    }

    for line in &v {
        for line2 in &v {
            let a: u32 = line.parse().unwrap();
            let b: u32 = line2.parse().unwrap();

            if a + b == 2020 {
                println!("{} * {} = {}", a, b, a * b);
            }
            for line3 in &v {
                let c: u32 = line3.parse().unwrap();

                if a + b + c == 2020 {
                    println!("{} * {} * {} = {}", a, b, c, a * b * c);
                }
            }
        }
    }
}