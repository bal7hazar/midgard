#[derive(Drop, Copy)]
trait DeckTrait<T> {
    fn count() -> u8;
    fn draw(id: u8) -> T;
    fn version(id: u8) -> u8;
}
