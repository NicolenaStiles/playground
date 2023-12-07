use std::fs::File;
use std::io::{self, BufRead};
use std::ops::{Range, RangeInclusive};

pub fn part_one(filepath: String) -> u32 {

    let mut lowest_location_number : u32 = 0;

    let mut seeds : Vec<usize> = vec![];

    let input_file = File::open(filepath).expect("File not found!");
    let reader = io::BufReader::new(input_file);

    for line in reader.lines() {
        match line {

            Ok(line) => {
                let seeds_test : Vec<_> = line.split(":").collect();
                if seeds_test[0] == "seeds" {
                    println!("{:?}", seeds_test);
                }

                let test_range = std::ops::RangeInclusive::new(0,10);
            }

            Err(error) => {
                eprintln!("Error reading line: {}", error);
            }
        }
    }

    return lowest_location_number;
}
