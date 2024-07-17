// Internal imports

use midgard::elements::blesses::interface::{BlessTrait, Resource, ResourceTrait};

impl Bless of BlessTrait {
    #[inline]
    fn requirement(version: u8) -> Resource {
        match version {
            0 => core::zeroable::Zeroable::zero(),
            1 => ResourceTrait::new(0, 1, 1, 0),
            2 => ResourceTrait::new(2, 1, 0, 0),
            _ => core::zeroable::Zeroable::zero(),
        }
    }

    #[inline]
    fn score(version: u8) -> u8 {
        match version {
            0 => 0,
            1 => 1,
            2 => 2,
            _ => 0,
        }
    }

    #[inline]
    fn resource(version: u8) -> Resource {
        match version {
            0 => core::zeroable::Zeroable::zero(),
            1 => ResourceTrait::new(0, 0, 0, 2),
            2 => ResourceTrait::new(0, 0, 0, 3),
            _ => core::zeroable::Zeroable::zero(),
        }
    }
}
