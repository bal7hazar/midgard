// Component

#[starknet::component]
mod PlayableComponent {
    // Core imports

    use core::debug::PrintTrait;

    // Starknet imports

    use midgard::models::game::AssertTrait;
    use midgard::store::StoreTrait;
    use starknet::ContractAddress;
    use starknet::info::get_caller_address;

    // Dojo imports

    use dojo::world::IWorldDispatcher;
    use dojo::world::IWorldDispatcherTrait;

    // Internal imports

    use midgard::constants;
    use midgard::store::{Store, StoreImpl};
    use midgard::models::game::{Game, GameTrait, GameAssert};
    use midgard::models::player::{Player, PlayerTrait, PlayerAssert};

    // Errors

    mod errors {}

    // Storage

    #[storage]
    struct Storage {
        seeds: LegacyMap::<felt252, bool>,
    }

    // Events

    #[event]
    #[derive(Drop, starknet::Event)]
    enum Event {}

    #[generate_trait]
    impl InternalImpl<
        TContractState, +HasComponent<TContractState>
    > of InternalTrait<TContractState> {
        fn start(self: @ComponentState<TContractState>, world: IWorldDispatcher,) -> u32 {
            // [Setup] Datastore
            let store: Store = StoreImpl::new(world);

            // [Check] Player exists
            let caller = get_caller_address();
            let mut player = store.player(caller.into());
            player.assert_exists();

            // [Check] Game is over
            let game = store.game(player.game_id);
            game.assert_is_over();

            // [Effect] Create game
            let game_id: u32 = world.uuid() + 1;
            let mut game = GameTrait::new(game_id, player.id, game_id.into());
            game.start();
            store.set_game(game);

            // [Effect] Update player
            player.game_id = game_id;
            store.set_player(player);

            // [Return] Game id
            game_id
        }

        fn hire(self: @ComponentState<TContractState>, world: IWorldDispatcher, builder_id: u8,) {
            // [Setup] Datastore
            let store: Store = StoreImpl::new(world);

            // [Check] Player exists
            let caller = get_caller_address();
            let mut player = store.player(caller.into());
            player.assert_exists();

            // [Check] Game exists and not over
            let mut game = store.game(player.game_id);
            game.assert_exists();
            game.assert_not_over();

            // [Effect] Perform action
            game.hire(builder_id);

            // [Effect] Update game
            store.set_game(game);
        }

        fn select(self: @ComponentState<TContractState>, world: IWorldDispatcher, building_id: u8) {
            // [Setup] Datastore
            let store: Store = StoreImpl::new(world);

            // [Check] Player exists
            let caller = get_caller_address();
            let player = store.player(caller.into());
            player.assert_exists();

            // [Check] Game exists and not over
            let mut game = store.game(player.game_id);
            game.assert_exists();
            game.assert_not_over();

            // [Effect] Discard game
            game.select(building_id);

            // [Effect] Update game
            store.set_game(game);
        }

        fn send(
            self: @ComponentState<TContractState>,
            world: IWorldDispatcher,
            builder_id: u8,
            building_id: u8
        ) {
            // [Setup] Datastore
            let store: Store = StoreImpl::new(world);

            // [Check] Player exists
            let caller = get_caller_address();
            let player = store.player(caller.into());
            player.assert_exists();

            // [Check] Game exists and not over
            let mut game = store.game(player.game_id);
            game.assert_exists();
            game.assert_not_over();

            // [Effect] Send builder
            game.send(builder_id, building_id);

            // [Effect] Update game
            store.set_game(game);
        }

        fn buy(self: @ComponentState<TContractState>, world: IWorldDispatcher, quantity: u8) {
            // [Setup] Datastore
            let store: Store = StoreImpl::new(world);

            // [Check] Player exists
            let caller = get_caller_address();
            let player = store.player(caller.into());
            player.assert_exists();

            // [Check] Game exists and not over
            let mut game = store.game(player.game_id);
            game.assert_exists();
            game.assert_not_over();

            // [Effect] Buy action point
            game.buy(quantity);

            // [Effect] Update game
            store.set_game(game);
        }
    }
}
