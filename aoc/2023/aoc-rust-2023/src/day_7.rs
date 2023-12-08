use std::fs::File;
use std::io::{self, BufRead};
use std::ops::{Range, RangeInclusive};
use std::collections::HashMap;

pub fn part_one(filepath: String) -> usize {

    let mut total_winnings : usize = 0;

    let input_file = File::open(filepath).expect("File not found!");
    let reader = io::BufReader::new(input_file);

    for line in reader.lines() {
        match line {

            Ok(line) => {
                let line_input : Vec<_> = line.split(" ").collect();
                let hand : String = line_input.first().unwrap().to_string();
                let bid : usize = line_input.last().unwrap().to_string()
                                                            .parse::<usize>().unwrap();

                let hand_chars : Vec<char> = hand.chars().collect();
                let mut hand_collection : HashMap<char, usize> = HashMap::new();

                for c in hand_chars{
                    match hand_collection.get_mut(&c) {
                        Some(count) => {
                            *count += 1;
                        }
                        None => {
                            hand_collection.insert(c, 1);
                        }
                    }
                }

                for (key, value) in hand_collection.into_iter() {
                    println!("Key: {key}, Count: {value}");
                }
                println!("--------------");
            }

            Err(error) => {
                eprintln!("Error reading line: {}", error);
            }
        }
    }

    return total_winnings;
}
