use std::char;
use std::fs::File;
use std::io::{self, BufRead};
use std::ops::RangeInclusive;

struct PartNumber {
    number : usize,
    start_idx : usize,
    end_idx : usize,
    is_valid : bool 
}

pub fn part_one_better(filepath: String) -> usize {
    let mut part_num_sum : usize = 0;

    let mut filtered_lines : Vec<String> = vec![];
    let mut parts : Vec<Vec<PartNumber>> = vec![];
    let mut symbox_idx : Vec<Vec<usize>> = vec![];

    let input_file = File::open(filepath).expect("File not found!");
    let reader = io::BufReader::new(input_file);

    for line in reader.lines() {
        match line {
            Ok(line) => {

                let mut line_symbol_idx : Vec<usize> = vec![];
                let mut line_parts : Vec<PartNumber> = vec![];

                // convert the base line from "." to " " to I can use 
                // char::is_ascii_punctuation
                let whitespace_filtered_line = line.replace(".", " ");
                let mut symbol_filtered_line : String = "".to_string();

                let chared_line : Vec<_> = whitespace_filtered_line.chars().collect();
                for (i, c) in chared_line.iter().enumerate() {
                    if char::is_ascii_punctuation(c) {
                        line_symbol_idx.push(i as usize);
                        symbol_filtered_line.push_str(" ");
                    } else {
                        symbol_filtered_line.push_str(&c.to_string());
                    }
                }

                // this one is strings
                let parts_strings : Vec<_> = symbol_filtered_line.split(" ")
                                                              .filter(|x| !x.is_empty())
                                                              .collect();

                for p_num in parts_strings {

                    let part_num = p_num.parse::<usize>().unwrap(); 
                    let part_num_start_idx = symbol_filtered_line.find(p_num).unwrap();
                    let part_num_end_idx = part_num_start_idx + p_num.len() - 1;
                    let valid = false;

                    line_parts.push(PartNumber { number: part_num, 
                                                 start_idx: part_num_start_idx, 
                                                 end_idx: part_num_end_idx,
                                                 is_valid: valid
                                                });

                }

                filtered_lines.push(symbol_filtered_line);
                symbox_idx.push(line_symbol_idx);
                parts.push(line_parts);

            }
            Err(error) => {
                eprintln!("Error reading line: {}", error);
            }
        }
    }

    // some constants to make things easier
    let num_lines : usize = filtered_lines.len();
    let line_len : usize = filtered_lines[0].len();

    println!("{:?}", symbox_idx);
    return part_num_sum;
}

pub fn part_one(filepath: String) -> u32 {

    let mut part_num_sum : u32 = 0;

    // filled out on first pass thru
    let mut symbol_idx : Vec<Vec<u32>> = vec![];
    let mut filtered_lines : Vec<String> = vec![];
    let mut part_nums : Vec<Vec<u32>> = vec![];
    let mut part_ranges : Vec<Vec<usize>> = vec![];

    let mut parts : Vec<Vec<PartNumber>> = vec![];

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

                let mut part_range : Vec<usize> = vec![];

                let chared_line : Vec<_> = whitespace_filtered_line.chars().collect();
                for (i, c) in chared_line.iter().enumerate() {
                    if char::is_ascii_punctuation(c) {
                        line_symbol_idx.push(i as u32);
                        symbol_filtered_line.push_str(" ");
                    } else {
                        symbol_filtered_line.push_str(&c.to_string());
                    }
                }

                // this one is strings
                let line_parts : Vec<_> = symbol_filtered_line.split(" ")
                                                              .filter(|x| !x.is_empty())
                                                              .collect();

                for p_num in line_parts {
                    let part_num_start_idx = symbol_filtered_line.find(p_num).unwrap();
                    let part_num_end_idx = part_num_start_idx + p_num.len() - 1;
                    part_range.push(part_num_start_idx);
                    part_range.push(part_num_end_idx);
                }

                // this one is u32s
                let line_part_nums : Vec<u32> = symbol_filtered_line.split(" ")
                                                                    .filter(|x| !x.is_empty())
                                                                    .map(|y| y.parse::<u32>().unwrap())
                                                                    .collect();

                part_nums.push(line_part_nums);
                symbol_idx.push(line_symbol_idx);
                filtered_lines.push(symbol_filtered_line);
                part_ranges.push(part_range);
            }

            Err(error) => {
                eprintln!("Error reading line: {}", error);
            }
        }
    }

    // debug only
    for element in filtered_lines {
        println!("{:?}", element);
    }
    println!("{:?}", symbol_idx);
    println!("{:?}", part_nums);
    println!("{:?}", part_ranges);

    return part_num_sum;
}

