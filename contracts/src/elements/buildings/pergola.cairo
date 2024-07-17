// Internal imports

use midgard::elements::buildings::interface::{BuildingTrait, Resource, ResourceTrait};

impl Building of BuildingTrait {
    #[inline]
    fn requirement() -> Resource {
        ResourceTrait::new(1, 0, 0, 1)
    }

    #[inline]
    fn score() -> u8 {
        0
    }

    #[inline]
    fn gold() -> u8 {
        8
    }
}
