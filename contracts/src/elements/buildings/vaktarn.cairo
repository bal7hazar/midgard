// Internal imports

use midgard::elements::buildings::interface::{BuildingTrait, Resource, ResourceTrait};

impl Building of BuildingTrait {
    #[inline]
    fn requirement() -> Resource {
        ResourceTrait::new(3, 3, 2, 2)
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
