//! Signable component

#[starknet::component]
mod SignableComponent {
    // Starknet imports

    use starknet::ContractAddress;
    use starknet::info::get_caller_address;

    // Dojo imports

    use dojo::world::IWorldDispatcher;

    // Internal imports

    use midgard::store::{Store, StoreImpl};
    use midgard::models::player::{Player, PlayerTrait, PlayerAssert};

    // Storage

    #[storage]
    struct Storage {}

    // Events

    #[event]
    #[derive(Drop, starknet::Event)]
    enum Event {}

    #[generate_trait]
    impl InternalImpl<
        TContractState, +HasComponent<TContractState>
    > of InternalTrait<TContractState> {
        fn signup(self: @ComponentState<TContractState>, world: IWorldDispatcher, name: felt252,) {
            // [Setup] Datastore
            let store: Store = StoreImpl::new(world);

            // [Check] Player not already exists
            let caller = get_caller_address();
            let player = store.player(caller.into());
            player.assert_not_exists();

            // [Effect] Create a new player
            let player = PlayerTrait::new(caller.into(), name);
            store.set_player(player);
        }

        fn rename(self: @ComponentState<TContractState>, world: IWorldDispatcher, name: felt252,) {
            // [Setup] Datastore
            let store: Store = StoreImpl::new(world);

            // [Check] Player exists
            let caller = get_caller_address();
            let mut player = store.player(caller.into());
            player.assert_exists();

            // [Effect] Create a new player
            player.rename(name);
            store.set_player(player);
        }
    }
}
