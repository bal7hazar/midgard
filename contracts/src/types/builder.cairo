// Internal imports

use midgard::elements::builders;
use midgard::types::resource::{Resource, ResourceTrait};

#[derive(Copy, Drop, Serde, Introspect)]
enum Builder {
    None,
    Trainee,
    Worker,
    Expert,
    Master,
}

#[generate_trait]
impl BuilderImpl of BuilderTrait {
    #[inline]
    fn index(self: Builder) -> u8 {
        let id: u8 = self.into();
        id - 1
    }

    #[inline]
    fn count(self: Builder) -> u8 {
        match self {
            Builder::None => 0,
            Builder::Trainee => builders::trainee::Builder::count(),
            Builder::Worker => builders::worker::Builder::count(),
            Builder::Expert => builders::expert::Builder::count(),
            Builder::Master => builders::master::Builder::count(),
        }
    }

    #[inline]
    fn cost(self: Builder) -> u8 {
        match self {
            Builder::None => 0,
            Builder::Trainee => builders::trainee::Builder::cost(),
            Builder::Worker => builders::worker::Builder::cost(),
            Builder::Expert => builders::expert::Builder::cost(),
            Builder::Master => builders::master::Builder::cost(),
        }
    }

    #[inline]
    fn resource(self: Builder, id: u8) -> Resource {
        match self {
            Builder::None => core::zeroable::Zeroable::zero(),
            Builder::Trainee => builders::trainee::Builder::resource(id),
            Builder::Worker => builders::worker::Builder::resource(id),
            Builder::Expert => builders::expert::Builder::resource(id),
            Builder::Master => builders::master::Builder::resource(id),
        }
    }
}

impl IntoBuilderFelt252 of core::Into<Builder, felt252> {
    #[inline(always)]
    fn into(self: Builder) -> felt252 {
        match self {
            Builder::None => 'NONE',
            Builder::Trainee => 'TRAINEE',
            Builder::Worker => 'WORKER',
            Builder::Expert => 'EXPERT',
            Builder::Master => 'MASTER',
        }
    }
}

impl IntoBuilderU8 of core::Into<Builder, u8> {
    #[inline(always)]
    fn into(self: Builder) -> u8 {
        match self {
            Builder::None => 0,
            Builder::Trainee => 1,
            Builder::Worker => 2,
            Builder::Expert => 3,
            Builder::Master => 4,
        }
    }
}

impl IntoU8Builder of core::Into<u8, Builder> {
    #[inline(always)]
    fn into(self: u8) -> Builder {
        let card: felt252 = self.into();
        match card {
            0 => Builder::None,
            1 => Builder::Trainee,
            2 => Builder::Worker,
            3 => Builder::Expert,
            4 => Builder::Master,
            _ => Builder::None,
        }
    }
}

impl BuilderPrint of core::debug::PrintTrait<Builder> {
    #[inline(always)]
    fn print(self: Builder) {
        let felt: felt252 = self.into();
        felt.print();
    }
}
