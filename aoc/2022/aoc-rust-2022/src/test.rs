mod day_1;

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn day_1_part_one() {
        assert_eq!(24000, day_1::part_one("input/day_1/test"));
    }

    #[test]
    fn day_1_part_two() {
        assert_eq!(45000, day_1::part_two("input/day_1/test"));
    }
}
