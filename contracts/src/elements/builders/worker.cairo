// Internal imports

use midgard::elements::builders::interface::{BuilderTrait, Resource, ResourceTrait};

impl Builder of BuilderTrait {
    #[inline]
    fn count() -> u8 {
        12
    }

    #[inline]
    fn cost() -> u8 {
        3
    }

    #[inline]
    fn resource(version: u8) -> Resource {
        match version {
            0 => core::zeroable::Zeroable::zero(),
            1 => ResourceTrait::new(2, 1, 0, 0),
            2 => ResourceTrait::new(2, 0, 1, 0),
            3 => ResourceTrait::new(2, 0, 0, 1),
            4 => ResourceTrait::new(1, 2, 0, 0),
            5 => ResourceTrait::new(0, 2, 1, 0),
            6 => ResourceTrait::new(0, 2, 0, 1),
            7 => ResourceTrait::new(1, 0, 2, 0),
            8 => ResourceTrait::new(0, 1, 2, 0),
            9 => ResourceTrait::new(0, 0, 2, 1),
            10 => ResourceTrait::new(1, 0, 0, 2),
            11 => ResourceTrait::new(0, 1, 0, 2),
            12 => ResourceTrait::new(0, 0, 1, 2),
            _ => core::zeroable::Zeroable::zero(),
        }
    }
}
