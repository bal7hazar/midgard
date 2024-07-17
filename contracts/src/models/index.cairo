#[derive(Copy, Drop, Serde, IntrospectPacked)]
#[dojo::model]
struct Player {
    #[key]
    id: felt252,
    game_id: u32,
    name: felt252,
}

#[derive(Copy, Drop, Serde, IntrospectPacked)]
#[dojo::model]
struct Game {
    #[key]
    id: u32,
    over: bool,
    score: u8,
    action: u8,
    gold: u16,
    buildings: u64,
    constructions: u64,
    structures: u64,
    builders: u64,
    workers: u64,
    works: felt252,
    seed: felt252,
    player_id: felt252,
}
