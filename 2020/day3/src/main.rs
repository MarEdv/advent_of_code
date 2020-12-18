use std::fs::File;
use std::io::{BufRead, BufReader};

fn slope(v: &Vec<String>, dx: usize, dy: usize) -> u32 {
    let mut i = 0;

    let debug = false;

    for y in (dy..v.len()).step_by(dy) {
        let yy = y;
        let string = v.get(yy).unwrap();
        let x = ((yy)*dx/dy)%string.len();
        let byte = string.as_bytes().get(x);

        let bb = string.as_bytes();
        if debug { print!("{}", std::str::from_utf8(&bb[..x]).unwrap()); }
        if b'#' == *byte.unwrap() {
            if debug { print!("X"); }
            i = i + 1;
        } else {
            if debug { print!("O"); }
        }
        if debug { println!("{}", std::str::from_utf8(&bb[x+1..]).unwrap()); }
    }

    i
}

fn main() {
    let filename = "input3.txt";

    let file = File::open(filename).unwrap();
    let reader = BufReader::new(file);

    let mut v: Vec<String> = Vec::new();
    for (_index, line) in reader.lines().enumerate() {
        v.push(line.unwrap());
    }

 
    let i1 = slope(&v, 3, 1);
    let j1 = slope(&v, 1, 1);
    let j2 = slope(&v, 5, 1);
    let j3 = slope(&v, 7, 1);
    let j4 = slope(&v, 1, 2);
    println!("Part 1: {}", i1);
    println!("Part 2: {} * {} * {} * {} * {} = {}", i1, j1, j2, j3, j4, (i1 * j1 * j2 * j3 * j4));
}