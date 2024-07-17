// Internal imports

use midgard::elements::builders::interface::{BuilderTrait, Resource, ResourceTrait};

impl Builder of BuilderTrait {
    #[inline]
    fn count() -> u8 {
        16
    }

    #[inline]
    fn cost() -> u8 {
        5
    }

    #[inline]
    fn resource(version: u8) -> Resource {
        match version {
            0 => core::zeroable::Zeroable::zero(),
            1 => ResourceTrait::new(0, 2, 3, 0),
            2 => ResourceTrait::new(0, 0, 3, 2),
            3 => ResourceTrait::new(2, 3, 0, 0),
            4 => ResourceTrait::new(0, 3, 2, 0),
            5 => ResourceTrait::new(3, 2, 0, 0),
            6 => ResourceTrait::new(3, 0, 0, 2),
            7 => ResourceTrait::new(2, 0, 0, 3),
            8 => ResourceTrait::new(0, 0, 2, 3),
            _ => core::zeroable::Zeroable::zero(),
        }
    }
}
