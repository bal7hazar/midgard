// Internal imports

use midgard::types::resource::{Resource, ResourceTrait};

#[derive(Drop, Copy)]
trait BuilderTrait {
    fn count() -> u8;
    fn cost() -> u8;
    fn resource(version: u8) -> Resource;
}
