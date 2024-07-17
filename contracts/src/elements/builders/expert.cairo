// Internal imports

use midgard::elements::builders::interface::{BuilderTrait, Resource, ResourceTrait};

impl Builder of BuilderTrait {
    #[inline]
    fn count() -> u8 {
        16
    }

    #[inline]
    fn cost() -> u8 {
        4
    }

    #[inline]
    fn resource(version: u8) -> Resource {
        match version {
            0 => core::zeroable::Zeroable::zero(),
            1 => ResourceTrait::new(1, 1, 1, 1),
            2 => ResourceTrait::new(1, 1, 1, 1),
            3 => ResourceTrait::new(3, 1, 0, 0),
            4 => ResourceTrait::new(0, 3, 0, 1),
            5 => ResourceTrait::new(1, 0, 3, 0),
            6 => ResourceTrait::new(0, 0, 1, 3),
            7 => ResourceTrait::new(2, 2, 0, 0),
            8 => ResourceTrait::new(2, 0, 2, 0),
            9 => ResourceTrait::new(2, 0, 0, 2),
            10 => ResourceTrait::new(0, 2, 2, 0),
            11 => ResourceTrait::new(0, 2, 0, 2),
            12 => ResourceTrait::new(0, 0, 2, 2),
            13 => ResourceTrait::new(2, 1, 1, 0),
            14 => ResourceTrait::new(1, 2, 0, 1),
            15 => ResourceTrait::new(1, 0, 2, 1),
            16 => ResourceTrait::new(0, 1, 1, 2),
            _ => core::zeroable::Zeroable::zero(),
        }
    }
}
