use std::fs::File;
use std::io::{self, BufRead};

pub fn part_one(filepath: String) -> usize {

    let mut num_steps : usize = 0;

    let input_file = File::open(filepath).expect("File not found!");
    let reader = io::BufReader::new(input_file);

    for line in reader.lines() {
        match line {

            Ok(line) => {
            }

            Err(error) => {
                eprintln!("Error reading line: {}", error);
            }
        }
    }

    return num_steps;
}
