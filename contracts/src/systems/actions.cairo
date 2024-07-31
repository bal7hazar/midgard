// Starknet imports

use starknet::ContractAddress;

// Dojo imports

use dojo::world::IWorldDispatcher;

// Interfaces

#[starknet::interface]
trait IActions<TContractState> {
    fn signup(self: @TContractState, world: IWorldDispatcher, name: felt252);
    fn rename(self: @TContractState, world: IWorldDispatcher, name: felt252);
    fn start(self: @TContractState, world: IWorldDispatcher) -> u32;
    fn hire(self: @TContractState, world: IWorldDispatcher, builder_id: u8);
    fn select(self: @TContractState, world: IWorldDispatcher, building_id: u8);
    fn send(self: @TContractState, world: IWorldDispatcher, builder_id: u8, building_id: u8);
    fn buy(self: @TContractState, world: IWorldDispatcher, quantity: u8);
    fn sell(self: @TContractState, world: IWorldDispatcher, quantity: u8);
}

// Contracts

#[starknet::contract]
mod actions {
    // Dojo imports

    use dojo::world;
    use dojo::world::IWorldDispatcher;
    use dojo::world::IWorldDispatcherTrait;
    use dojo::world::IDojoResourceProvider;

    // Component imports

    use midgard::components::initializable::InitializableComponent;
    use midgard::components::signable::SignableComponent;
    use midgard::components::playable::PlayableComponent;

    // Local imports

    use super::IActions;

    // Components

    component!(path: InitializableComponent, storage: initializable, event: InitializableEvent);
    #[abi(embed_v0)]
    impl WorldProviderImpl =
        InitializableComponent::WorldProviderImpl<ContractState>;
    #[abi(embed_v0)]
    impl DojoInitImpl = InitializableComponent::DojoInitImpl<ContractState>;
    component!(path: SignableComponent, storage: signable, event: SignableEvent);
    impl SignableInternalImpl = SignableComponent::InternalImpl<ContractState>;
    component!(path: PlayableComponent, storage: playable, event: PlayableEvent);
    impl PlayableInternalImpl = PlayableComponent::InternalImpl<ContractState>;

    // Storage

    #[storage]
    struct Storage {
        #[substorage(v0)]
        initializable: InitializableComponent::Storage,
        #[substorage(v0)]
        signable: SignableComponent::Storage,
        #[substorage(v0)]
        playable: PlayableComponent::Storage,
    }

    // Events

    #[event]
    #[derive(Drop, starknet::Event)]
    enum Event {
        #[flat]
        InitializableEvent: InitializableComponent::Event,
        #[flat]
        SignableEvent: SignableComponent::Event,
        #[flat]
        PlayableEvent: PlayableComponent::Event,
    }

    // Implementations

    #[abi(embed_v0)]
    impl DojoResourceProviderImpl of IDojoResourceProvider<ContractState> {
        fn dojo_resource(self: @ContractState) -> felt252 {
            'actions'
        }
    }

    #[abi(embed_v0)]
    impl ActionsImpl of IActions<ContractState> {
        fn signup(self: @ContractState, world: IWorldDispatcher, name: felt252) {
            self.signable.signup(world, name);
        }

        fn rename(self: @ContractState, world: IWorldDispatcher, name: felt252) {
            self.signable.rename(world, name);
        }

        fn start(self: @ContractState, world: IWorldDispatcher,) -> u32 {
            self.playable.start(world)
        }

        fn hire(self: @ContractState, world: IWorldDispatcher, builder_id: u8,) {
            self.playable.hire(world, builder_id)
        }

        fn select(self: @ContractState, world: IWorldDispatcher, building_id: u8,) {
            self.playable.select(world, building_id)
        }

        fn send(self: @ContractState, world: IWorldDispatcher, builder_id: u8, building_id: u8,) {
            self.playable.send(world, builder_id, building_id)
        }

        fn buy(self: @ContractState, world: IWorldDispatcher, quantity: u8,) {
            self.playable.buy(world, quantity)
        }

        fn sell(self: @ContractState, world: IWorldDispatcher, quantity: u8,) {
            self.playable.sell(world, quantity)
        }
    }
}
