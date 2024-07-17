// Internal imports

use midgard::elements::decks::interface::DeckTrait;
use midgard::types::builder::Builder;

impl Deck of DeckTrait<Builder> {
    #[inline]
    fn count() -> u8 {
        return 42;
    }

    #[inline]
    fn draw(id: u8) -> Builder {
        match id {
            0 => Builder::None,
            1 => Builder::Trainee,
            2 => Builder::Trainee,
            3 => Builder::Trainee,
            4 => Builder::Trainee,
            5 => Builder::Trainee,
            6 => Builder::Trainee,
            7 => Builder::Worker,
            8 => Builder::Worker,
            9 => Builder::Worker,
            10 => Builder::Worker,
            11 => Builder::Worker,
            12 => Builder::Worker,
            13 => Builder::Worker,
            14 => Builder::Worker,
            15 => Builder::Worker,
            16 => Builder::Worker,
            17 => Builder::Worker,
            18 => Builder::Worker,
            19 => Builder::Expert,
            20 => Builder::Expert,
            21 => Builder::Expert,
            22 => Builder::Expert,
            23 => Builder::Expert,
            24 => Builder::Expert,
            25 => Builder::Expert,
            26 => Builder::Expert,
            27 => Builder::Expert,
            28 => Builder::Expert,
            29 => Builder::Expert,
            30 => Builder::Expert,
            31 => Builder::Expert,
            32 => Builder::Expert,
            33 => Builder::Expert,
            34 => Builder::Expert,
            35 => Builder::Master,
            36 => Builder::Master,
            37 => Builder::Master,
            38 => Builder::Master,
            39 => Builder::Master,
            40 => Builder::Master,
            41 => Builder::Master,
            42 => Builder::Master,
            _ => Builder::None,
        }
    }

    #[inline]
    fn version(id: u8) -> u8 {
        match id {
            0 => 0,
            1 => 1,
            2 => 2,
            3 => 3,
            4 => 4,
            5 => 5,
            6 => 6,
            7 => 1,
            8 => 2,
            9 => 3,
            10 => 4,
            11 => 5,
            12 => 6,
            13 => 7,
            14 => 8,
            15 => 9,
            16 => 10,
            17 => 11,
            18 => 12,
            19 => 1,
            20 => 2,
            21 => 3,
            22 => 4,
            23 => 5,
            24 => 6,
            25 => 7,
            26 => 8,
            27 => 9,
            28 => 10,
            29 => 11,
            30 => 12,
            31 => 13,
            32 => 14,
            33 => 15,
            34 => 16,
            35 => 1,
            36 => 2,
            37 => 3,
            38 => 4,
            39 => 5,
            40 => 6,
            41 => 7,
            42 => 8,
            _ => 0,
        }
    }
}
