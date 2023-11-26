use std::fs::File;
use std::io::{self, BufRead};

fn main() {

    let test_file = File::open("input/input-day-1").expect("File not found!");
    let reader = io::BufReader::new(test_file);

    for line in reader.lines() {

        match line {
            Ok(line) => {
                println!("{}", line);
            }

            Err(error) => {
                eprintln!("Error reading line: {}", error);
            }
        }

    }

}

