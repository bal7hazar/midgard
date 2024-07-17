// Internal imports

use midgard::elements::buildings::interface::{BuildingTrait, Resource, ResourceTrait};

impl Building of BuildingTrait {
    #[inline]
    fn requirement() -> Resource {
        ResourceTrait::new(4, 2, 4, 0)
    }

    #[inline]
    fn score() -> u8 {
        5
    }

    #[inline]
    fn gold() -> u8 {
        18
    }
}
