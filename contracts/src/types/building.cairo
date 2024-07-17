// Internal imports

use midgard::elements::buildings;
use midgard::types::resource::{Resource, ResourceTrait};

#[derive(Copy, Drop, Serde, Introspect)]
enum Building {
    None,
    Kloster,
    Gard,
    Vaktarn,
    Pergola,
    Vertshus,
    Kornlager,
    Landgard,
    Postgard,
    Svinehus,
    Steinbru,
    Taketbru,
    Vannmolle,
    Vindmolle,
    Litenhus,
    Byhus,
    Landhus,
    Borgerskapshus,
    Vaskeri,
    Strahytte,
    Hotell,
    Markedshall,
    Smie,
    Fjos,
    Kirke,
    Stall,
    Strahus,
    Hof,
    Offerkapell,
    Hytte,
    Festning,
    Trehytte,
    Gjestgiveri,
    Vatnsvei,
    Gydingar,
}

#[generate_trait]
impl BuildingImpl of BuildingTrait {
    #[inline]
    fn index(self: Building) -> u8 {
        let id: u8 = self.into();
        id - 1
    }

    #[inline]
    fn requirement(self: Building) -> Resource {
        match self {
            Building::None => core::zeroable::Zeroable::zero(),
            Building::Kloster => buildings::kloster::Building::requirement(),
            Building::Gard => buildings::gard::Building::requirement(),
            Building::Vaktarn => buildings::vaktarn::Building::requirement(),
            Building::Pergola => buildings::pergola::Building::requirement(),
            Building::Vertshus => buildings::vertshus::Building::requirement(),
            Building::Kornlager => buildings::kornlager::Building::requirement(),
            Building::Landgard => buildings::landgard::Building::requirement(),
            Building::Postgard => buildings::postgard::Building::requirement(),
            Building::Svinehus => buildings::svinehus::Building::requirement(),
            Building::Steinbru => buildings::steinbru::Building::requirement(),
            Building::Taketbru => buildings::taketbru::Building::requirement(),
            Building::Vannmolle => buildings::vannmolle::Building::requirement(),
            Building::Vindmolle => buildings::vindmolle::Building::requirement(),
            Building::Litenhus => buildings::litenhus::Building::requirement(),
            Building::Byhus => buildings::byhus::Building::requirement(),
            Building::Landhus => buildings::landhus::Building::requirement(),
            Building::Borgerskapshus => buildings::borgerskapshus::Building::requirement(),
            Building::Vaskeri => buildings::vaskeri::Building::requirement(),
            Building::Strahytte => buildings::strahytte::Building::requirement(),
            Building::Hotell => buildings::hotell::Building::requirement(),
            Building::Markedshall => buildings::markedshall::Building::requirement(),
            Building::Smie => buildings::smie::Building::requirement(),
            Building::Fjos => buildings::fjos::Building::requirement(),
            Building::Kirke => buildings::kirke::Building::requirement(),
            Building::Stall => buildings::stall::Building::requirement(),
            Building::Strahus => buildings::strahus::Building::requirement(),
            Building::Hof => buildings::hof::Building::requirement(),
            Building::Offerkapell => buildings::offerkapell::Building::requirement(),
            Building::Hytte => buildings::hytte::Building::requirement(),
            Building::Festning => buildings::festning::Building::requirement(),
            Building::Trehytte => buildings::trehytte::Building::requirement(),
            Building::Gjestgiveri => buildings::gjestgiveri::Building::requirement(),
            Building::Vatnsvei => buildings::vatnsvei::Building::requirement(),
            Building::Gydingar => buildings::gydingar::Building::requirement(),
        }
    }

    #[inline]
    fn score(self: Building) -> u8 {
        match self {
            Building::None => 0,
            Building::Kloster => buildings::kloster::Building::score(),
            Building::Gard => buildings::gard::Building::score(),
            Building::Vaktarn => buildings::vaktarn::Building::score(),
            Building::Pergola => buildings::pergola::Building::score(),
            Building::Vertshus => buildings::vertshus::Building::score(),
            Building::Kornlager => buildings::kornlager::Building::score(),
            Building::Landgard => buildings::landgard::Building::score(),
            Building::Postgard => buildings::postgard::Building::score(),
            Building::Svinehus => buildings::svinehus::Building::score(),
            Building::Steinbru => buildings::steinbru::Building::score(),
            Building::Taketbru => buildings::taketbru::Building::score(),
            Building::Vannmolle => buildings::vannmolle::Building::score(),
            Building::Vindmolle => buildings::vindmolle::Building::score(),
            Building::Litenhus => buildings::litenhus::Building::score(),
            Building::Byhus => buildings::byhus::Building::score(),
            Building::Landhus => buildings::landhus::Building::score(),
            Building::Borgerskapshus => buildings::borgerskapshus::Building::score(),
            Building::Vaskeri => buildings::vaskeri::Building::score(),
            Building::Strahytte => buildings::strahytte::Building::score(),
            Building::Hotell => buildings::hotell::Building::score(),
            Building::Markedshall => buildings::markedshall::Building::score(),
            Building::Smie => buildings::smie::Building::score(),
            Building::Fjos => buildings::fjos::Building::score(),
            Building::Kirke => buildings::kirke::Building::score(),
            Building::Stall => buildings::stall::Building::score(),
            Building::Strahus => buildings::strahus::Building::score(),
            Building::Hof => buildings::hof::Building::score(),
            Building::Offerkapell => buildings::offerkapell::Building::score(),
            Building::Hytte => buildings::hytte::Building::score(),
            Building::Festning => buildings::festning::Building::score(),
            Building::Trehytte => buildings::trehytte::Building::score(),
            Building::Gjestgiveri => buildings::gjestgiveri::Building::score(),
            Building::Vatnsvei => buildings::vatnsvei::Building::score(),
            Building::Gydingar => buildings::gydingar::Building::score(),
        }
    }

    #[inline]
    fn gold(self: Building) -> u8 {
        match self {
            Building::None => 0,
            Building::Kloster => buildings::kloster::Building::gold(),
            Building::Gard => buildings::gard::Building::gold(),
            Building::Vaktarn => buildings::vaktarn::Building::gold(),
            Building::Pergola => buildings::pergola::Building::gold(),
            Building::Vertshus => buildings::vertshus::Building::gold(),
            Building::Kornlager => buildings::kornlager::Building::gold(),
            Building::Landgard => buildings::landgard::Building::gold(),
            Building::Postgard => buildings::postgard::Building::gold(),
            Building::Svinehus => buildings::svinehus::Building::gold(),
            Building::Steinbru => buildings::steinbru::Building::gold(),
            Building::Taketbru => buildings::taketbru::Building::gold(),
            Building::Vannmolle => buildings::vannmolle::Building::gold(),
            Building::Vindmolle => buildings::vindmolle::Building::gold(),
            Building::Litenhus => buildings::litenhus::Building::gold(),
            Building::Byhus => buildings::byhus::Building::gold(),
            Building::Landhus => buildings::landhus::Building::gold(),
            Building::Borgerskapshus => buildings::borgerskapshus::Building::gold(),
            Building::Vaskeri => buildings::vaskeri::Building::gold(),
            Building::Strahytte => buildings::strahytte::Building::gold(),
            Building::Hotell => buildings::hotell::Building::gold(),
            Building::Markedshall => buildings::markedshall::Building::gold(),
            Building::Smie => buildings::smie::Building::gold(),
            Building::Fjos => buildings::fjos::Building::gold(),
            Building::Kirke => buildings::kirke::Building::gold(),
            Building::Stall => buildings::stall::Building::gold(),
            Building::Strahus => buildings::strahus::Building::gold(),
            Building::Hof => buildings::hof::Building::gold(),
            Building::Offerkapell => buildings::offerkapell::Building::gold(),
            Building::Hytte => buildings::hytte::Building::gold(),
            Building::Festning => buildings::festning::Building::gold(),
            Building::Trehytte => buildings::trehytte::Building::gold(),
            Building::Gjestgiveri => buildings::gjestgiveri::Building::gold(),
            Building::Vatnsvei => buildings::vatnsvei::Building::gold(),
            Building::Gydingar => buildings::gydingar::Building::gold(),
        }
    }
}

impl IntoBuildingFelt252 of core::Into<Building, felt252> {
    #[inline(always)]
    fn into(self: Building) -> felt252 {
        match self {
            Building::None => 'NONE',
            Building::Kloster => 'KLOSTER',
            Building::Gard => 'GARD',
            Building::Vaktarn => 'VAKTARN',
            Building::Pergola => 'PERGOLA',
            Building::Vertshus => 'VERTSHUS',
            Building::Kornlager => 'KORNLAGER',
            Building::Landgard => 'LANDGARD',
            Building::Postgard => 'POSTGARD',
            Building::Svinehus => 'SVINEHUS',
            Building::Steinbru => 'STEINBRU',
            Building::Taketbru => 'TAKETBRU',
            Building::Vannmolle => 'VANNMOLLE',
            Building::Vindmolle => 'VINDMOLLE',
            Building::Litenhus => 'LITENHUS',
            Building::Byhus => 'BYHUS',
            Building::Landhus => 'LANDHUS',
            Building::Borgerskapshus => 'BORGERSKAPSHUS',
            Building::Vaskeri => 'VASKERI',
            Building::Strahytte => 'STRAHYTTE',
            Building::Hotell => 'HOTELL',
            Building::Markedshall => 'MARKEDSHALL',
            Building::Smie => 'SMIE',
            Building::Fjos => 'FJOS',
            Building::Kirke => 'KIRKE',
            Building::Stall => 'STALL',
            Building::Strahus => 'STRAHUS',
            Building::Hof => 'HOF',
            Building::Offerkapell => 'OFFERKAPELL',
            Building::Hytte => 'HYTTE',
            Building::Festning => 'FESTNING',
            Building::Trehytte => 'TREHYTTE',
            Building::Gjestgiveri => 'GJESTGIVERI',
            Building::Vatnsvei => 'VATNSVEI',
            Building::Gydingar => 'GYDINGAR',
        }
    }
}

impl IntoBuildingU8 of core::Into<Building, u8> {
    #[inline(always)]
    fn into(self: Building) -> u8 {
        match self {
            Building::None => 0,
            Building::Kloster => 1,
            Building::Gard => 2,
            Building::Vaktarn => 3,
            Building::Pergola => 4,
            Building::Vertshus => 5,
            Building::Kornlager => 6,
            Building::Landgard => 7,
            Building::Postgard => 8,
            Building::Svinehus => 9,
            Building::Steinbru => 10,
            Building::Taketbru => 11,
            Building::Vannmolle => 12,
            Building::Vindmolle => 13,
            Building::Litenhus => 14,
            Building::Byhus => 15,
            Building::Landhus => 16,
            Building::Borgerskapshus => 17,
            Building::Vaskeri => 18,
            Building::Strahytte => 19,
            Building::Hotell => 20,
            Building::Markedshall => 21,
            Building::Smie => 22,
            Building::Fjos => 23,
            Building::Kirke => 24,
            Building::Stall => 25,
            Building::Strahus => 26,
            Building::Hof => 27,
            Building::Offerkapell => 28,
            Building::Hytte => 29,
            Building::Festning => 30,
            Building::Trehytte => 31,
            Building::Gjestgiveri => 32,
            Building::Vatnsvei => 33,
            Building::Gydingar => 34,
        }
    }
}

impl IntoU8Building of core::Into<u8, Building> {
    #[inline(always)]
    fn into(self: u8) -> Building {
        let card: felt252 = self.into();
        match card {
            0 => Building::None,
            1 => Building::Kloster,
            2 => Building::Gard,
            3 => Building::Vaktarn,
            4 => Building::Pergola,
            5 => Building::Vertshus,
            6 => Building::Kornlager,
            7 => Building::Landgard,
            8 => Building::Postgard,
            9 => Building::Svinehus,
            10 => Building::Steinbru,
            11 => Building::Taketbru,
            12 => Building::Vannmolle,
            13 => Building::Vindmolle,
            14 => Building::Litenhus,
            15 => Building::Byhus,
            16 => Building::Landhus,
            17 => Building::Borgerskapshus,
            18 => Building::Vaskeri,
            19 => Building::Strahytte,
            20 => Building::Hotell,
            21 => Building::Markedshall,
            22 => Building::Smie,
            23 => Building::Fjos,
            24 => Building::Kirke,
            25 => Building::Stall,
            26 => Building::Strahus,
            27 => Building::Hof,
            28 => Building::Offerkapell,
            29 => Building::Hytte,
            30 => Building::Festning,
            31 => Building::Trehytte,
            32 => Building::Gjestgiveri,
            33 => Building::Vatnsvei,
            34 => Building::Gydingar,
            _ => Building::None,
        }
    }
}

impl BuildingPrint of core::debug::PrintTrait<Building> {
    #[inline(always)]
    fn print(self: Building) {
        let felt: felt252 = self.into();
        felt.print();
    }
}
