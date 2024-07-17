// Internal imports

use midgard::elements::blesses;
use midgard::types::resource::{Resource, ResourceTrait};

#[derive(Copy, Drop, Serde, Introspect)]
enum Bless {
    None,
    Odin,
    Vidarr,
    Volundr,
    Skadi,
}

#[generate_trait]
impl BlessImpl of BlessTrait {
    #[inline]
    fn requirement(self: Bless, id: u8) -> Resource {
        match self {
            Bless::None => core::zeroable::Zeroable::zero(),
            Bless::Odin => blesses::odin::Bless::requirement(id),
            Bless::Vidarr => blesses::vidarr::Bless::requirement(id),
            Bless::Volundr => blesses::volundr::Bless::requirement(id),
            Bless::Skadi => blesses::skadi::Bless::requirement(id),
        }
    }

    #[inline]
    fn score(self: Bless, id: u8) -> u8 {
        match self {
            Bless::None => 0,
            Bless::Odin => blesses::odin::Bless::score(id),
            Bless::Vidarr => blesses::vidarr::Bless::score(id),
            Bless::Volundr => blesses::volundr::Bless::score(id),
            Bless::Skadi => blesses::skadi::Bless::score(id),
        }
    }

    #[inline]
    fn resource(self: Bless, id: u8) -> Resource {
        match self {
            Bless::None => core::zeroable::Zeroable::zero(),
            Bless::Odin => blesses::odin::Bless::resource(id),
            Bless::Vidarr => blesses::vidarr::Bless::resource(id),
            Bless::Volundr => blesses::volundr::Bless::resource(id),
            Bless::Skadi => blesses::skadi::Bless::resource(id),
        }
    }
}

impl IntoBlessFelt252 of core::Into<Bless, felt252> {
    #[inline(always)]
    fn into(self: Bless) -> felt252 {
        match self {
            Bless::None => 'NONE',
            Bless::Odin => 'ODIN',
            Bless::Vidarr => 'VIDARR',
            Bless::Volundr => 'VOLUNDR',
            Bless::Skadi => 'SKADI',
        }
    }
}

impl IntoBlessU8 of core::Into<Bless, u8> {
    #[inline(always)]
    fn into(self: Bless) -> u8 {
        match self {
            Bless::None => 0,
            Bless::Odin => 1,
            Bless::Vidarr => 2,
            Bless::Volundr => 3,
            Bless::Skadi => 4,
        }
    }
}

impl IntoU8Bless of core::Into<u8, Bless> {
    #[inline(always)]
    fn into(self: u8) -> Bless {
        let card: felt252 = self.into();
        match card {
            0 => Bless::None,
            1 => Bless::Odin,
            2 => Bless::Vidarr,
            3 => Bless::Volundr,
            4 => Bless::Skadi,
            _ => Bless::None,
        }
    }
}

impl BlessPrint of core::debug::PrintTrait<Bless> {
    #[inline(always)]
    fn print(self: Bless) {
        let felt: felt252 = self.into();
        felt.print();
    }
}
