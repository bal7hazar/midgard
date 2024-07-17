use core::traits::TryInto;
// Core imports

use core::debug::PrintTrait;
use core::poseidon::{PoseidonTrait, HashState};
use core::hash::HashStateTrait;
use core::array::ArrayTrait;

// External imports

use alexandria_math::bitmap::Bitmap;
use origami::random::deck::{Deck, DeckTrait};

// Inernal imports

use midgard::constants;
use midgard::models::index::Game;
use midgard::types::builder::{Builder, BuilderTrait};
use midgard::types::building::{Building, BuildingTrait};
use midgard::types::deck::{BuilderDeck, BuildingDeck};
use midgard::types::resource::{Resource, ResourceTrait};
use midgard::helpers::packer::Packer;

mod errors {
    const GAME_NOT_ENOUGH_ACTION: felt252 = 'Game: not enough action';
    const GAME_NOT_EXISTS: felt252 = 'Game: does not exist';
    const GAME_IS_OVER: felt252 = 'Game: is over';
    const GAME_NOT_OVER: felt252 = 'Game: not over';
    const GAME_BUILDER_ALREADY_HIRED: felt252 = 'Game: builder already hired';
    const GAME_BUILDER_NOT_HIRED: felt252 = 'Game: builder not hired';
    const GAME_BUILDER_NOT_HIREABLE: felt252 = 'Game: builder not hireable';
    const GAME_BUILDING_ALREADY_SELECTED: felt252 = 'Game: building already selected';
    const GAME_BUILDING_NOT_SELECTED: felt252 = 'Game: building not selected';
    const GAME_BUILDING_NOT_SELECTABLE: felt252 = 'Game: building not selectable';
    const GAME_BUILDING_ALREADY_BUILT: felt252 = 'Game: building already built';
    const GAME_WORKER_NOT_FREE: felt252 = 'Game: worker not free';
    const GAME_COST_NOT_AFFORDABLE: felt252 = 'Game: cost is not affordable';
}

#[generate_trait]
impl GameImpl of GameTrait {
    #[inline]
    fn new(id: u32, player_id: felt252, seed: felt252) -> Game {
        // [Effect] Create a new game
        Game {
            id,
            over: false,
            score: 0,
            action: constants::DEFAULT_GAME_ACTION,
            gold: constants::DEFAULT_GAME_GOLD,
            buildings: 0,
            constructions: 0,
            structures: 0,
            builders: 0,
            workers: 0,
            works: 0,
            seed: seed,
            player_id: player_id,
        }
    }

    fn score(self: Game) -> u8 {
        // [Compute] Score for each completed structures
        let mut score = 0;
        let mut packed = self.structures;
        let mut building_id: u8 = 1;
        loop {
            if packed == 0 {
                break score;
            };
            if packed % 2 == 1 {
                let building: Building = BuildingDeck::get(building_id);
                score += building.score();
            }
            building_id += 1;
            packed /= 2;
        }
    }

    #[inline]
    fn start(ref self: Game) {
        // [Effect] Draw 5 builders
        let count: u32 = BuilderDeck::count().into();
        let mut deck: Deck = DeckTrait::from_bitmap(self.seed, count, self.builders.into());
        self.builders = Bitmap::set_bit_at(self.builders, deck.draw().into() - 1, true);
        self.builders = Bitmap::set_bit_at(self.builders, deck.draw().into() - 1, true);
        self.builders = Bitmap::set_bit_at(self.builders, deck.draw().into() - 1, true);
        self.builders = Bitmap::set_bit_at(self.builders, deck.draw().into() - 1, true);
        self.builders = Bitmap::set_bit_at(self.builders, deck.draw().into() - 1, true);
        self.seed = self.reseed();
        // [Effect] Draw 5 buildings
        let count: u32 = BuildingDeck::count().into();
        let mut deck: Deck = DeckTrait::from_bitmap(self.seed, count, self.buildings.into());
        self.buildings = Bitmap::set_bit_at(self.buildings, deck.draw().into() - 1, true);
        self.buildings = Bitmap::set_bit_at(self.buildings, deck.draw().into() - 1, true);
        self.buildings = Bitmap::set_bit_at(self.buildings, deck.draw().into() - 1, true);
        self.buildings = Bitmap::set_bit_at(self.buildings, deck.draw().into() - 1, true);
        self.buildings = Bitmap::set_bit_at(self.buildings, deck.draw().into() - 1, true);
        self.seed = self.reseed();
    }

    #[inline]
    fn reseed(ref self: Game) -> felt252 {
        let state: HashState = PoseidonTrait::new();
        let state = state.update(self.seed);
        let state = state.update(self.seed);
        state.finalize()
    }

    #[inline]
    fn hire(ref self: Game, builder_id: u8) {
        // [Check] Action is available
        self.assert_is_available();

        // [Check] Builder is hireable and not already hired
        let builder: Builder = BuilderDeck::get(builder_id);
        let index = builder.index();
        self.assert_is_hireable(index);
        self.assert_not_hired(index);

        // [Effect] Hire builder
        self.workers = Bitmap::set_bit_at(self.workers, index, true);

        // [Effect] Draw a new builder
        let count: u32 = BuilderDeck::count().into();
        let mut deck: Deck = DeckTrait::from_bitmap(self.seed, count, self.builders.into());
        self.builders = Bitmap::set_bit_at(self.builders, deck.draw().into() - 1, true);

        // [Effect] Update action points and assess game over
        self.action -= 1;
        self.assess_over();
    }

    #[inline]
    fn select(ref self: Game, building_id: u8) {
        // [Check] Action is available
        self.assert_is_available();

        // [Check] Building is selectable and not already selected
        let building: Building = BuildingDeck::get(building_id);
        let index = building.index();
        self.assert_is_selectable(index);
        self.assert_not_selected(index);

        // [Effect] Select building
        self.constructions = Bitmap::set_bit_at(self.constructions, index, true);

        // [Effect] Draw a new building
        let count: u32 = BuildingDeck::count().into();
        let mut deck: Deck = DeckTrait::from_bitmap(self.seed, count, self.buildings.into());
        self.buildings = Bitmap::set_bit_at(self.buildings, deck.draw().into() - 1, true);

        // [Effect] Update action points and assess game over
        self.action -= 1;
        self.assess_over();
    }

    #[inline]
    fn send(ref self: Game, builder_id: u8, building_id: u8) {
        // [Check] Action is available
        self.assert_is_available();

        // [Check] Builder is hired and not already at work
        let builder: Builder = BuilderDeck::get(builder_id);
        let builder_index = builder.index();
        self.assert_is_hired(builder_index);
        self.assert_not_working(builder_index);

        // [Check] Building is selected and not already built
        let building: Building = BuildingDeck::get(building_id);
        let building_index = building.index();
        self.assert_is_selected(building_index);
        self.assert_not_built(building_index);

        // [Check] Builder cost is affordable
        let cost: u16 = builder.cost().into();
        self.assert_is_affordable(cost);

        // [Effect] Send builder to the construction site
        let works: u256 = self.workers.into();
        let works = Packer::set(works, builder_index, constants::WORK_BIT_COUNT, building_id);
        self.works = works.try_into().unwrap();

        // [Effect] Assess construction status
        self.assess_built(building_id);

        // [Effect] Update action points, pay the cost and assess game over
        self.gold -= cost;
        self.action -= 1;
        self.assess_over();
    }

    #[inline]
    fn buy(ref self: Game, quantity: u8) {
        // [Check] Action is affordable
        let cost: u16 = quantity.into() * constants::DEFAULT_ACTION_COST;
        self.assert_is_affordable(cost);

        // [Effect] Buy action points
        self.gold -= cost;
        self.action += quantity;
    }

    fn assess_built(ref self: Game, building_id: u8) {
        // [Compute] Resources requirement
        let building: Building = BuildingDeck::get(building_id);
        let requirement = building.requirement();
        // [Compute] Reousrces prodivded
        let mut provided: Resource = core::zeroable::Zeroable::zero();
        let works: u256 = self.works.into();
        let mut works: Array<u8> = Packer::unpack(works, constants::WORK_BIT_COUNT);
        let mut builder_id = 1;
        let afforded = loop {
            match works.pop_front() {
                Option::Some(id) => {
                    if id == building_id {
                        let builder: Builder = BuilderDeck::get(builder_id);
                        provided = provided + builder.resource(builder_id);
                        if provided >= requirement {
                            break true;
                        }
                    }
                    builder_id += 1;
                },
                Option::None => { break false; },
            }
        };
        // [Effect] Build construction into structure if afforded
        if afforded {
            let index = building.index();
            self.structures = Bitmap::set_bit_at(self.structures, index, true);
            // [Effect] Update game score
            self.score = self.score();
        }
    }

    #[inline]
    fn assess_over(ref self: Game) {
        // [Effect] Over if no move left and card one is zero
        self.over = self.action == 0;
    }
}

impl ZeroableGame of core::Zeroable<Game> {
    #[inline]
    fn zero() -> Game {
        Game {
            id: 0,
            over: false,
            score: 0,
            action: 0,
            gold: 0,
            buildings: 0,
            constructions: 0,
            structures: 0,
            builders: 0,
            workers: 0,
            works: 0,
            seed: 0,
            player_id: 0,
        }
    }

    #[inline]
    fn is_zero(self: Game) -> bool {
        0 == self.player_id
    }

    #[inline]
    fn is_non_zero(self: Game) -> bool {
        !self.is_zero()
    }
}

#[generate_trait]
impl GameAssert of AssertTrait {
    #[inline]
    fn assert_exists(self: Game) {
        assert(self.is_non_zero(), errors::GAME_NOT_EXISTS);
    }

    #[inline]
    fn assert_not_over(self: Game) {
        assert(!self.over, errors::GAME_IS_OVER);
    }

    #[inline]
    fn assert_is_over(self: Game) {
        assert(self.over || self.is_zero(), errors::GAME_NOT_OVER);
    }

    #[inline]
    fn assert_is_available(self: Game) {
        assert(self.action > 0, errors::GAME_NOT_ENOUGH_ACTION);
    }

    #[inline]
    fn assert_is_affordable(self: Game, cost: u16) {
        assert(self.gold >= cost, errors::GAME_COST_NOT_AFFORDABLE);
    }

    #[inline]
    fn assert_not_hired(self: Game, index: u8) {
        let is_hired = Bitmap::get_bit_at(self.workers, index);
        assert(!is_hired, errors::GAME_BUILDER_ALREADY_HIRED);
    }

    #[inline]
    fn assert_is_hired(self: Game, index: u8) {
        let is_hired = Bitmap::get_bit_at(self.workers, index);
        assert(is_hired, errors::GAME_BUILDER_NOT_HIRED);
    }

    #[inline]
    fn assert_is_hireable(self: Game, index: u8) {
        let is_hirable = Bitmap::get_bit_at(self.builders, index);
        assert(is_hirable, errors::GAME_BUILDER_NOT_HIREABLE);
    }

    #[inline]
    fn assert_not_selected(self: Game, index: u8) {
        let is_selected = Bitmap::get_bit_at(self.constructions, index);
        assert(!is_selected, errors::GAME_BUILDING_ALREADY_SELECTED);
    }

    #[inline]
    fn assert_is_selected(self: Game, index: u8) {
        let is_selected = Bitmap::get_bit_at(self.constructions, index);
        assert(is_selected, errors::GAME_BUILDING_NOT_SELECTED);
    }

    #[inline]
    fn assert_is_selectable(self: Game, index: u8) {
        let is_selectable = Bitmap::get_bit_at(self.buildings, index);
        assert(is_selectable, errors::GAME_BUILDING_NOT_SELECTABLE);
    }

    #[inline]
    fn assert_not_built(self: Game, index: u8) {
        let is_built = Bitmap::get_bit_at(self.structures, index);
        assert(!is_built, errors::GAME_BUILDING_ALREADY_BUILT);
    }

    #[inline]
    fn assert_not_working(self: Game, index: u8) {
        let works: u256 = self.works.into();
        let building_id: u8 = Packer::get(works, index, constants::WORK_BIT_COUNT);
        // [Check] Worker has no building assigned
        if building_id == 0 {
            return;
        }
        // [Check] Assigned building is already finished
        let is_built = Bitmap::get_bit_at(self.structures, building_id - 1);
        assert(is_built, errors::GAME_WORKER_NOT_FREE);
    }
}

#[cfg(test)]
mod tests {
    // Core imports

    use core::debug::PrintTrait;

    // Local imports

    use super::constants;
    use super::{Game, GameTrait, AssertTrait, Deck, DeckTrait};
    use super::{Building, BuildingTrait, BuildingDeck};

    // Constants

    const GAME_ID: u32 = 1;
    const PLAYER_ID: felt252 = 'PLAYER';
    const SEED: felt252 = 'SEED';

    #[test]
    fn test_game_new() {
        let game = GameTrait::new(GAME_ID, PLAYER_ID, SEED);
        assert_eq!(game.id, GAME_ID);
        assert_eq!(game.player_id, PLAYER_ID);
        assert_eq!(game.seed, SEED);
    }

    #[test]
    fn test_game_score() {
        let mut game = GameTrait::new(GAME_ID, PLAYER_ID, SEED);
        game.structures = 0b1010;
        let score = game.score();
        let two: Building = BuildingDeck::get(2);
        let four: Building = BuildingDeck::get(4);
        let expected: u8 = two.score() + four.score();
        assert_eq!(score, expected);
    }

    #[test]
    fn test_game_start() {
        let mut game = GameTrait::new(GAME_ID, PLAYER_ID, SEED);
        game.start();
        assert_eq!(game.builders, 0b10000001000000000000100000010000000001);
        assert_eq!(game.buildings, 0b110000100011000000000000000);
    }

    #[test]
    fn test_game_reseed() {
        let mut game = GameTrait::new(GAME_ID, PLAYER_ID, SEED);
        let new_seed = game.reseed();
        assert_ne!(new_seed, SEED);
    }

    #[test]
    fn test_game_hire() {
        let mut game = GameTrait::new(GAME_ID, PLAYER_ID, SEED);
        game.start();
        assert_eq!(game.workers, 0);
        assert_eq!(game.builders, 0b10000001000000000000100000010000000001);
        game.hire(1);
        assert_eq!(game.workers, 0b1);
        assert_eq!(game.builders, 0b10001001000000000000100000010000000001);
    }

    #[test]
    fn test_game_select() {
        let mut game = GameTrait::new(GAME_ID, PLAYER_ID, SEED);
        game.start();
        assert_eq!(game.constructions, 0);
        assert_eq!(game.buildings, 0b110000100011000000000000000);
        game.select(16);
        assert_eq!(game.constructions, 0b1000000000000000);
        assert_eq!(game.buildings, 0b110000100011100000000000000);
    }

    #[test]
    fn test_game_send() {
        let mut game = GameTrait::new(GAME_ID, PLAYER_ID, SEED);
        game.start();
        game.hire(1);
        game.select(16);
        game.send(1, 16);
        assert_eq!(game.works, 16);
    }

    #[test]
    #[should_panic(expected: ('Game: worker not free',))]
    fn test_game_resend() {
        let mut game = GameTrait::new(GAME_ID, PLAYER_ID, SEED);
        game.start();
        game.hire(1);
        game.select(16);
        game.send(1, 16);
        game.send(1, 16);
    }

    #[test]
    fn test_game_buy() {
        let mut game = GameTrait::new(GAME_ID, PLAYER_ID, SEED);
        let action = game.action;
        let gold = game.gold;
        let quantity: u8 = 2;
        let cost: u16 = constants::DEFAULT_ACTION_COST * quantity.into();
        game.buy(quantity);
        assert_eq!(game.action, action + 2);
        assert_eq!(game.gold, gold - cost);
    }

    #[test]
    fn test_game_assess_built() {
        let mut game = GameTrait::new(GAME_ID, PLAYER_ID, SEED);
        game.start();
        game.hire(1);
        game.select(16);
        game.send(1, 16);
        assert_eq!(game.structures, 0);
        assert_eq!(game.score, 0);
    }

    #[test]
    fn test_game_assess_over() {
        let mut game = GameTrait::new(GAME_ID, PLAYER_ID, SEED);
        game.action = 1;
        game.assess_over();
        assert_eq!(game.over, false);
        game.action = 0;
        game.assess_over();
        assert_eq!(game.over, true);
    }
}
