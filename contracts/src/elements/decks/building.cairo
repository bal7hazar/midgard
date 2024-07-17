// Internal imports

use midgard::elements::decks::interface::DeckTrait;
use midgard::types::building::Building;

impl Deck of DeckTrait<Building> {
    #[inline]
    fn count() -> u8 {
        return 34;
    }

    #[inline]
    fn draw(id: u8) -> Building {
        id.into()
    }

    #[inline]
    fn version(id: u8) -> u8 {
        1
    }
}
