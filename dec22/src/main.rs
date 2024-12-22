use std::collections::{HashMap, HashSet};

use itertools::Itertools;

const FILE: &str = "../input.txt";
// const FILE: &str = "../example.txt";
// const FILE: &str = "../example2.txt";
// const FILE: &str = "../example3.txt";

fn main() {
	let input = std::fs::read_to_string(FILE)
		.unwrap()
		.lines()
		.map(|l| l.parse().unwrap())
		.collect::<Vec<i64>>();

	let result1 = part1(&input);
	let result2 = part2(&input);

	println!("Part1: {result1}\nPart2: {result2}");
}

fn step(mut s: i64) -> i64 {
	s = ((s * 64) ^ s) % 16777216;
	s = ((s / 32) ^ s) % 16777216;
	s = ((s * 2048) ^ s) % 16777216;
	s
}

fn part1(input: &[i64]) -> i64 {
	input
		.iter()
		.copied()
		.map(|n| {
			let mut input = n;
			for _ in 0..2000 {
				input = step(input);
			}
			input
		})
		.sum::<i64>()
}

fn part2(input: &[i64]) -> i64 {
	let mut subsequence_values = HashMap::new();

	for seq in input.iter().copied().map(|mut n| {
		std::iter::from_fn(move || {
			let last = n % 10;
			n = step(n);
			let this = n % 10;
			Some((this, (this - last) as u8))
		})
		.take(2000)
	}) {
		let mut seen = HashSet::new();
		for (num, pattern) in seq
			.tuple_windows()
			.map(|((_, a), (_, b), (_, c), (n, d))| (n, i32::from_be_bytes([a, b, c, d])))
		{
			if seen.contains(&pattern) {
				continue;
			}
			seen.insert(pattern);
			*subsequence_values.entry(pattern).or_insert(0) += num;
		}
	}

	subsequence_values.values().copied().max().unwrap_or(0)
}
