mod day_1;
mod day_2;

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn day_1_part_one() {
        assert_eq!(142, day_1::part_one("input/day_1/test_1"));
    }

    #[test]
    fn day_1_part_two() {
        assert_eq!(282, day_1::part_two("input/day_1/test_2"));
    }


    #[test]
    fn day_2_part_one() {
        assert_eq!(8, day_2::part_one("input/day_2/test_1"));
    }

}
