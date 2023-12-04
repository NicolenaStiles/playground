use std::fs::File;
use std::io::{self, BufRead};

pub fn part_one(filepath: String) -> u32 {

    let input_file = File::open(filepath).expect("File not found!");
    let reader = io::BufReader::new(input_file);

    let mut sum : u32 = 0;
    
    for line in reader.lines() {
        match line {

            Ok(line) => {
                let v: Vec<_> = line.match_indices(char::is_numeric).collect();
                let double_digit = vec![v.first().unwrap().1, v.last().unwrap().1].join("");
                sum += double_digit.parse::<u32>().unwrap();
            }
            
            Err(error) => {
                eprintln!("Error reading line: {}", error);
            }
        }
    }

    return sum;
}

pub fn part_two(filepath: String) -> u32 {

    let input_file = File::open(filepath).expect("File not found!");
    let reader = io::BufReader::new(input_file);

    let mut sum : u32 = 0;
    
    for line in reader.lines() {
        match line {

            Ok(line) => {

                // I feel like an idiot doing this.
                // Padding in front of and behind number so I don't cause
                // unexpected weirdness somehow (like "threeeight" or some shit
                // idk)
                let filtered_string = line
                    .replace("zero", "z0o")
                    .replace("one", "o1e")
                    .replace("two", "t2o")
                    .replace("three", "t3e")
                    .replace("four", "f4r")
                    .replace("five", "f5e")
                    .replace("six", "s6x")
                    .replace("seven", "s7n")
                    .replace("eight", "e8t")
                    .replace("nine", "n9e");

                // copy/pasted from pt1
                let v: Vec<_> = filtered_string.match_indices(char::is_numeric).collect();
                let double_digit = vec![v.first().unwrap().1, v.last().unwrap().1].join("");
                sum += double_digit.parse::<u32>().unwrap();

            }
            
            Err(error) => {
                eprintln!("Error reading line: {}", error);
            }
        }
    }

    return sum;
}

