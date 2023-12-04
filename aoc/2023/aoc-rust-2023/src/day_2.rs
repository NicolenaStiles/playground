use std::fs::File;
use std::io::{self, BufRead};

pub fn part_one(filepath: String) -> u32 {

    let red_cubes : u32 = 12;
    let green_cubes : u32 = 13;
    let blue_cubes : u32 = 14;

    let mut id_sum : u32 = 0;
    let mut sus_rounds : Vec<u32> = vec![];

    let input_file = File::open(filepath).expect("File not found!");
    let reader = io::BufReader::new(input_file);

    for line in reader.lines() {
        match line {

            Ok(line) => {

                let v: Vec<_> = line.split(":").collect();
                let game_idx : u32 = v[0].split(" ")
                                         .last().unwrap()
                                         .parse::<u32>().unwrap();

                let clean_games : String = v[1].replace(",", "");
                let pulls : Vec<_> = clean_games.split(";")
                                                .collect();

                let mut is_sus : bool = false;
                for pull in pulls.iter() {
                    let mut split_pulls : Vec<_> = pull.split(" ").collect();
                    split_pulls.remove(0);
                    let mut curr_num : u32 = 0;
                    for (i, val) in split_pulls.iter().enumerate() {
                        // odds are nums
                        if i % 2 == 0 {
                            curr_num = val.parse::<u32>().unwrap();
                        // evens are color names
                        } else {
                            match *val {
                                "red" => {
                                    if curr_num > red_cubes {
                                        is_sus = true;
                                    }
                                }
                                "green" => {
                                    if curr_num > green_cubes {
                                        is_sus = true;
                                    }
                                }
                                "blue" => {
                                    if curr_num > blue_cubes {
                                        is_sus = true;
                                    }
                                }
                                _ => {
                                    println!("got nothing!");
                                }
                            }
                        }
                    }
                }

                if !is_sus {
                    sus_rounds.push(game_idx);
                }
            }
            
            Err(error) => {
                eprintln!("Error reading line: {}", error);
            }
        }
    }

    sus_rounds.iter().for_each(|x| id_sum+=x);
    return id_sum;
}

pub fn part_two(filepath: String) -> u32 {

    let mut sum_pows : u32 = 0;
    let mut round_pows : Vec<u32> = vec![];

    let input_file = File::open(filepath).expect("File not found!");
    let reader = io::BufReader::new(input_file);

    for line in reader.lines() {
        match line {

            Ok(line) => {

                let v: Vec<_> = line.split(":").collect();
                let clean_games : String = v[1].replace(",", "");
                let pulls : Vec<_> = clean_games.split(";")
                                                .collect();

                let mut min_red_cubes : u32 = 0;
                let mut min_green_cubes : u32 = 0;
                let mut min_blue_cubes : u32 = 0;

                for pull in pulls.iter() {
                    let mut split_pulls : Vec<_> = pull.split(" ").collect();
                    split_pulls.remove(0);
                    let mut curr_num : u32 = 0;
                    for (i, val) in split_pulls.iter().enumerate() {
                        // odds are nums
                        if i % 2 == 0 {
                            curr_num = val.parse::<u32>().unwrap();
                        // evens are color names
                        } else {
                            match *val {
                                "red" => {
                                    if curr_num > min_red_cubes {
                                        min_red_cubes = curr_num;
                                    }
                                }
                                "green" => {
                                    if curr_num > min_green_cubes {
                                        min_green_cubes = curr_num;
                                    }
                                }
                                "blue" => {
                                    if curr_num > min_blue_cubes {
                                        min_blue_cubes = curr_num;
                                    }
                                }
                                _ => {
                                    println!("got nothing!");
                                }
                            }
                        }
                    }
                }

                round_pows.push(min_red_cubes * min_green_cubes * min_blue_cubes);

            }
            
            Err(error) => {
                eprintln!("Error reading line: {}", error);
            }
        }
    }

    round_pows.iter().for_each(|x| sum_pows+=x);
    return sum_pows;
}
