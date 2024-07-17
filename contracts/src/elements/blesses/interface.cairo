// Internal imports

use midgard::types::resource::{Resource, ResourceTrait};

#[derive(Drop, Copy)]
trait BlessTrait {
    fn requirement(version: u8) -> Resource;
    fn score(version: u8) -> u8;
    fn resource(version: u8) -> Resource;
}
