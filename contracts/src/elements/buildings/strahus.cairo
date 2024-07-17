// Internal imports

use midgard::elements::buildings::interface::{BuildingTrait, Resource, ResourceTrait};

impl Building of BuildingTrait {
    #[inline]
    fn requirement() -> Resource {
        ResourceTrait::new(0, 2, 1, 2)
    }

    #[inline]
    fn score() -> u8 {
        2
    }

    #[inline]
    fn gold() -> u8 {
        10
    }
}
