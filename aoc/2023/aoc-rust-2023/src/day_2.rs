use std::fs::File;
use std::io::{self, BufRead};

pub fn part_one(filepath: String) -> u32 {

    let red_cubes : u32 = 12;
    let green_cubes : u32 = 13;
    let blue_cubes : u32 = 14;
    let mut id_sum : u32 = 0;

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


    return id_sum;
}
