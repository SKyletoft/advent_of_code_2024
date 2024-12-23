use std::collections::{HashMap, HashSet};

// const FILE: &str = "../example.txt";
const FILE: &str = "../input.txt";

type SmallString = smallstr::SmallString<[u8; 2]>;

fn main() {
	let mut mappings = HashMap::<SmallString, usize>::new();
	let input = std::fs::read_to_string(FILE)
		.unwrap()
		.lines()
		.map(|l| {
			let a = &l[..2];
			let b = &l[3..];
			let len = mappings.len() as _;
			let a_ = *mappings.entry(a.into()).or_insert(len);
			let len = mappings.len() as _;
			let b_ = *mappings.entry(b.into()).or_insert(len);
			(a_.min(b_), a_.max(b_))
		})
		.collect::<Vec<_>>();
	let inv_mappings = mappings
		.into_iter()
		.map(|(k, v)| (v, k))
		.collect::<HashMap<_, _>>();

	let mut neighbours = vec![Vec::<usize>::new(); inv_mappings.len()];
	let mut clusters = HashSet::<Vec<usize>>::new();

	for (a, b) in input.iter().copied() {
		let b_neighbours = &neighbours[b];
		for &neighbour in neighbours[a]
			.iter()
			.filter(|x| b_neighbours.contains(x) && **x != a && **x != b)
		{
			let mut cluster = vec![a, b, neighbour];
			cluster.sort_unstable();
			clusters.insert(cluster);
		}

		neighbours[a].push(b);
		neighbours[b].push(a);
	}

	let result1 = part1(&inv_mappings, &clusters);
	let result2 = part2(&inv_mappings, clusters, &neighbours);

	println!("Part1: {result1}\nPart2: {result2}");
}

fn part1(inv_mappings: &HashMap<usize, SmallString>, clusters: &HashSet<Vec<usize>>) -> usize {
	clusters
		.iter()
		.filter(|c| c.iter().any(|pc| inv_mappings[pc].starts_with('t')))
		.count()
}

fn part2(
	inv_mappings: &HashMap<usize, SmallString>,
	mut clusters: HashSet<Vec<usize>>,
	neighbours: &[Vec<usize>],
) -> String {
	while clusters.len() > 1 {
		let mut bigger_clusters = HashSet::new();
		for cluster in clusters.iter() {
			let mut seen = HashSet::new();
			for version in cluster
				.iter()
				.flat_map(|&c| neighbours[c].iter())
				.copied()
				.filter(|cand| {
					seen.insert(*cand)
						&& !cluster.contains(cand)
						&& cluster.iter().all(|&c| neighbours[c].contains(cand))
				}) {
				let mut next_gen = cluster.to_vec();
				let idx = next_gen.binary_search(&version).unwrap_err();
				next_gen.insert(idx, version);
				bigger_clusters.insert(next_gen);
			}
		}
		clusters = bigger_clusters;
	}

	let mut final_cluster = clusters
		.iter()
		.next()
		.unwrap()
		.iter()
		.map(|pc| inv_mappings[pc].clone())
		.collect::<Vec<_>>();
	final_cluster.sort_unstable();
	final_cluster.join(",")
}
