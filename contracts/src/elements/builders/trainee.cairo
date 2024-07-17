// Internal imports

use midgard::elements::builders::interface::{BuilderTrait, Resource, ResourceTrait};

impl Builder of BuilderTrait {
    #[inline]
    fn count() -> u8 {
        6
    }

    #[inline]
    fn cost() -> u8 {
        2
    }

    #[inline]
    fn resource(version: u8) -> Resource {
        match version {
            0 => core::zeroable::Zeroable::zero(),
            1 => ResourceTrait::new(0, 1, 1, 0),
            2 => ResourceTrait::new(0, 0, 1, 1),
            3 => ResourceTrait::new(0, 1, 0, 1),
            4 => ResourceTrait::new(1, 0, 1, 0),
            5 => ResourceTrait::new(1, 1, 0, 0),
            6 => ResourceTrait::new(1, 0, 0, 1),
            _ => core::zeroable::Zeroable::zero(),
        }
    }
}
