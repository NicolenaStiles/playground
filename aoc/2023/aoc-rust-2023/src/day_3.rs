use std::char;
use std::fs::File;
use std::io::{self, BufRead};

pub fn part_one(filepath: String) -> u32 {

    let mut part_num_sum : u32 = 0;

    let mut symbol_idx : Vec<Vec<u32>> = vec![];
    let mut filtered_lines : Vec<String> = vec![];

    let input_file = File::open(filepath).expect("File not found!");
    let reader = io::BufReader::new(input_file);

    for (l, line) in reader.lines().enumerate() {

        let mut line_symbol_idx : Vec<u32> = vec![];
        let mut line_parts : Vec<u32> = vec![];

        match line {
            Ok(line) => {

                // convert the base line from "." to " " to I can use 
                // char::is_ascii_punctuation
                let whitespace_filtered_line = line.replace(".", " ");
                let mut symbol_filtered_line : String = "".to_string();

                let chared_line : Vec<_> = whitespace_filtered_line.chars().collect();
                for (i, c) in chared_line.iter().enumerate() {
                    if char::is_ascii_punctuation(c) {
                        line_symbol_idx.push(i as u32);
                        symbol_filtered_line.push_str(" ");
                    } else {
                        symbol_filtered_line.push_str(&c.to_string());
                    }
                }

                /*
                // this one is strings
                let line_parts : Vec<_> = symbol_filtered_line.split(" ")
                                                              .filter(|x| !x.is_empty())
                                                              .collect();

                for p_num in line_parts {
                    let part_num_idx = symbol_filtered_line.find(p_num).unwrap();
                }

                // this one is u32s
                let line_part_nums : Vec<u32> = symbol_filtered_line.split(" ")
                                                                    .filter(|x| !x.is_empty())
                                                                    .map(|y| y.parse::<u32>().unwrap())
                                                                    .collect();
                */

                symbol_idx.push(line_symbol_idx);
                filtered_lines.push(symbol_filtered_line);
            }

            Err(error) => {
                eprintln!("Error reading line: {}", error);
            }
        }
    }

    for element in filtered_lines {
        println!("{:?}", element);
    }
    println!("{:?}", symbol_idx);

    return part_num_sum;
}

