// Internal imports

use midgard::elements::decks;
use midgard::types::builder::Builder;
use midgard::types::building::Building;

#[generate_trait]
impl BuilderDeck of BuilderDeckTrait {
    #[inline]
    fn count() -> u8 {
        decks::builder::Deck::count()
    }

    #[inline]
    fn get(id: u8) -> Builder {
        decks::builder::Deck::draw(id)
    }

    #[inline]
    fn version(id: u8) -> u8 {
        decks::builder::Deck::version(id)
    }
}

#[generate_trait]
impl BuildingDeck of BuildingDeckTrait {
    #[inline]
    fn count() -> u8 {
        decks::building::Deck::count()
    }

    #[inline]
    fn get(id: u8) -> Building {
        decks::building::Deck::draw(id)
    }

    #[inline]
    fn version(id: u8) -> u8 {
        decks::building::Deck::version(id)
    }
}
