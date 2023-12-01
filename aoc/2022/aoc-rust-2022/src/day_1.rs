use std::fs::File;
use std::io::{self, BufRead};

pub fn part_one(filepath: String) -> u32 {

    let input_file = File::open(filepath).expect("File not found!");
    let reader = io::BufReader::new(input_file);

    let mut curr_sum : u32 = 0;
    let mut cal_sums : Vec<u32> = vec![];

    for line in reader.lines() {
        match line {
            Ok(line) => {
                match line.as_str() {
                    "" => {
                        cal_sums.push(curr_sum);
                        curr_sum = 0;
                    }
                    _ => {
                        curr_sum += line.parse::<u32>().unwrap();
                    }
                }
                
            }

            Err(error) => {
                eprintln!("Error reading line: {}", error);
            }
        }
    }

    cal_sums.push(curr_sum);
    cal_sums.sort();
    
    return *cal_sums.last().unwrap();

}

pub fn part_two(filepath: String) -> u32 {

    let input_file = File::open(filepath).expect("File not found!");
    let reader = io::BufReader::new(input_file);

    let mut curr_sum : u32 = 0;
    let mut cal_sums : Vec<u32> = vec![];

    for line in reader.lines() {
        match line {
            Ok(line) => {
                match line.as_str() {
                    "" => {
                        cal_sums.push(curr_sum);
                        curr_sum = 0;
                    }
                    _ => {
                        curr_sum += line.parse::<u32>().unwrap();
                    }
                }
                
            }

            Err(error) => {
                eprintln!("Error reading line: {}", error);
            }
        }
    }

    cal_sums.push(curr_sum);
    cal_sums.sort();

    let top_three : u32 = cal_sums[cal_sums.len()-1] +
                         cal_sums[cal_sums.len()-2] +
                         cal_sums[cal_sums.len()-3] ;

    return top_three;    

}
