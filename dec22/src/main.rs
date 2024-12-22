use std::collections::{BTreeSet, HashSet};

const FILE: &str = "../input.txt";
// const FILE: &str = "../example.txt";
// const FILE: &str = "../example2.txt";
// const FILE: &str = "../example3.txt";

type SmallVec = smallvec::SmallVec<[i64; 4]>;

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

fn part1(input: &Vec<i64>) -> i64 {
	input
		.iter()
		.copied()
		.map(|n| repeat(step, 2000, n))
		.sum::<i64>()
}

fn repeat(f: impl Fn(i64) -> i64, n: i64, mut input: i64) -> i64 {
	for _ in 0..n {
		input = f(input);
	}
	input
}

fn step(mut s: i64) -> i64 {
	s = ((s * 64) ^ s) % 16777216;
	s = ((s / 32) ^ s) % 16777216;
	s = ((s * 2048) ^ s) % 16777216;
	s
}

fn part2(input: &[i64]) -> i64 {
	let sequences = input
		.iter()
		.copied()
		.map(|mut n| {
			std::iter::from_fn(|| {
				let last = n % 10;
				n = step(n);
				let this = n % 10;
				Some(this - last)
			})
			.take(2000)
			.collect::<Vec<_>>()
		})
		.collect::<Vec<_>>();
	let subsequences = sequences
		.iter()
		.flat_map(|seq| seq.windows(4).map(SmallVec::from_slice))
		.collect::<BTreeSet<SmallVec>>();

	let res = subsequences
		.iter()
		.map(|subseq| {
			sequences
				.iter()
				.zip(input.iter())
				.map(|(seq, secret)| {
					seq.windows(4)
						.map(SmallVec::from_slice)
						.position(|sv| &sv == subseq)
						.map(|idx| repeat(step, (idx + 4) as _, *secret) % 10)
						.unwrap_or(0)
				})
				.sum::<i64>()
		})
		.max()
		.unwrap_or(0);

	res
}
