// Internal imports

use midgard::elements::buildings::interface::{BuildingTrait, Resource, ResourceTrait};

impl Building of BuildingTrait {
    #[inline]
    fn requirement() -> Resource {
        ResourceTrait::new(0, 1, 2, 0)
    }

    #[inline]
    fn score() -> u8 {
        1
    }

    #[inline]
    fn gold() -> u8 {
        6
    }
}
