// Internal imports

use midgard::elements::buildings::interface::{BuildingTrait, Resource, ResourceTrait};

impl Building of BuildingTrait {
    #[inline]
    fn requirement() -> Resource {
        ResourceTrait::new(2, 2, 2, 2)
    }

    #[inline]
    fn score() -> u8 {
        4
    }

    #[inline]
    fn gold() -> u8 {
        16
    }
}
