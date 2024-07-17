// Internal imports

use midgard::elements::buildings::interface::{BuildingTrait, Resource, ResourceTrait};

impl Building of BuildingTrait {
    #[inline]
    fn requirement() -> Resource {
        ResourceTrait::new(5, 3, 5, 3)
    }

    #[inline]
    fn score() -> u8 {
        7
    }

    #[inline]
    fn gold() -> u8 {
        20
    }
}
