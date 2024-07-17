// Internal imports

use midgard::elements::buildings::interface::{BuildingTrait, Resource, ResourceTrait};

impl Building of BuildingTrait {
    #[inline]
    fn requirement() -> Resource {
        ResourceTrait::new(4, 2, 0, 2)
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
