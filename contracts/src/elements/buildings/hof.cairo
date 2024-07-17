// Internal imports

use midgard::elements::buildings::interface::{BuildingTrait, Resource, ResourceTrait};

impl Building of BuildingTrait {
    #[inline]
    fn requirement() -> Resource {
        ResourceTrait::new(5, 4, 4, 4)
    }

    #[inline]
    fn score() -> u8 {
        8
    }

    #[inline]
    fn gold() -> u8 {
        20
    }
}
