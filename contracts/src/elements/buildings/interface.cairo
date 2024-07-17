// Internal imports

use midgard::types::resource::{Resource, ResourceTrait};

#[derive(Drop, Copy)]
trait BuildingTrait {
    fn requirement() -> Resource;
    fn score() -> u8;
    fn gold() -> u8;
}
