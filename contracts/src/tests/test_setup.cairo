// Core imports

use core::debug::PrintTrait;

// Starknet imports

use starknet::testing::{set_contract_address, set_transaction_hash};

// Dojo imports

use dojo::world::{IWorldDispatcher, IWorldDispatcherTrait};

// Internal imports

use midgard::constants;
use midgard::store::{Store, StoreTrait};
use midgard::models::game::{Game, GameTrait};
use midgard::models::player::{Player, PlayerTrait};
use midgard::systems::actions::IActionsDispatcherTrait;

// Test imports

use midgard::tests::setup::{setup, setup::{Systems, PLAYER}};

#[test]
fn test_actions_setup() {
    // [Setup]
    let (world, _, context) = setup::spawn_game();
    let store = StoreTrait::new(world);

    // [Assert]
    let game = store.game(context.game_id);
    assert(game.id == context.game_id, 'Game: id');
}
