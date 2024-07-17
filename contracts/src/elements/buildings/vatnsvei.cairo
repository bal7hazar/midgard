// Internal imports

use midgard::elements::buildings::interface::{BuildingTrait, Resource, ResourceTrait};

impl Building of BuildingTrait {
    #[inline]
    fn requirement() -> Resource {
        ResourceTrait::new(5, 2, 5, 0)
    }

    #[inline]
    fn score() -> u8 {
        6
    }

    #[inline]
    fn gold() -> u8 {
        20
    }
}
