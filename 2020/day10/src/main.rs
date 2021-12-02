fn main() {
    let filename = "input10.txt";

    let mut adaptors:Vec<i64> = slurp::read_all_lines(filename).unwrap().iter()
        .map(|line| line.parse().unwrap()).collect();
        
    adaptors.sort();

    let mut diff1 = 1;
    let mut diff3 = 1;
    for x in 0..adaptors.len()-1 {
        let jolt1 = adaptors.get(x).unwrap();
        let jolt2 = adaptors.get(x+1).unwrap();
        if jolt2 - jolt1 == 1 {
            diff1 += 1;
        }
        if jolt2 - jolt1 == 3 {
            diff3 += 1;
        }

    }

    println!("Part 1: {} * {} = {}", diff1, diff3, diff1 * diff3);
}
