use std::fs::File;
use std::io::{self, BufRead};

pub fn part_one(filepath: String) -> u32 {

    let mut winning_score : u32 = 0;

    let input_file = File::open(filepath).expect("File not found!");
    let reader = io::BufReader::new(input_file);

    for line in reader.lines() {
        match line {
            Ok(line) => {

                let mut win_count : u32 = 0;

                let cards : Vec<_>  = line.split("|").collect();

                let mut winning_nums_string : Vec<_> = cards[0].split(":").collect();
                winning_nums_string.remove(0);
                let winning_nums : Vec<_> = winning_nums_string[0].split(" ")
                                                                  .filter(|x| !x.is_empty())
                                                                  .collect();

                let player_card_string : String = cards[1].split(":").collect();
                let player_nums : Vec<_> = player_card_string.split(" ")
                                                             .filter(|x| !x.is_empty())
                                                             .collect();

                for num in winning_nums {
                    if player_nums.contains(&num) {
                        win_count += 1;
                    }
                }
               
                if win_count > 0 {
                    let base : u32 = 2;
                    winning_score += base.pow(win_count - 1);
                }
            }

            Err(error) => {
                eprintln!("Error reading line: {}", error);
            }
        }
    }

    return winning_score;
}

pub fn part_two(filepath: String) -> u32 {

    let mut total_card_count: u32 = 0;

    let mut card_wins : Vec<u32> = [].to_vec();
    let mut card_count : Vec<u32> = [].to_vec();

    let input_file = File::open(filepath).expect("File not found!");
    let reader = io::BufReader::new(input_file);

    for line in reader.lines() {
        match line {
            Ok(line) => {

                let mut win_count : u32 = 0;

                let cards : Vec<_>  = line.split("|").collect();

                let mut winning_nums_string : Vec<_> = cards[0].split(":").collect();
                winning_nums_string.remove(0);
                let winning_nums : Vec<_> = winning_nums_string[0].split(" ")
                                                                  .filter(|x| !x.is_empty())
                                                                  .collect();

                let player_card_string : String = cards[1].split(":").collect();
                let player_nums : Vec<_> = player_card_string.split(" ")
                                                             .filter(|x| !x.is_empty())
                                                             .collect();

                for num in winning_nums {
                    if player_nums.contains(&num) {
                        win_count += 1;
                    }
                }

                card_count.push(1);
                card_wins.push(win_count);
            }

            Err(error) => {
                eprintln!("Error reading line: {}", error);
            }
        }
    }

    for (card, wins) in card_wins.iter().enumerate() {

        let base_idx = card as usize + 1;
        let top_idx = card as usize + *wins as usize;

        for n in base_idx..top_idx {
            card_count[n] += 1;
        }

    }

    println!("{:?}", card_count);

    return total_card_count;
}
