mod day1;

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn day_1_part_one() {
        assert_eq!(142, day1::part_one("input/day_1/test_1"));
    }

    #[test]
    fn day_1_part_two() {
        assert_eq!(282, day1::part_two("input/day_1/test_2"));
    }

}
