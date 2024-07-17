mod constants;
mod store;

mod helpers {
    mod math;
    mod packer;
}

mod elements {
    mod achievements {
        mod interface;
    }
    mod decks {
        mod interface;
        mod builder;
        mod building;
    }
    mod blesses {
        mod interface;
        mod odin;
        mod vidarr;
        mod volundr;
        mod skadi;
    }
    mod builders {
        mod interface;
        mod trainee;
        mod worker;
        mod expert;
        mod master;
    }
    mod buildings {
        mod interface;
        mod kloster;
        mod gard;
        mod vaktarn;
        mod pergola;
        mod vertshus;
        mod kornlager;
        mod landgard;
        mod postgard;
        mod svinehus;
        mod steinbru;
        mod taketbru;
        mod vannmolle;
        mod vindmolle;
        mod litenhus;
        mod byhus;
        mod landhus;
        mod borgerskapshus;
        mod vaskeri;
        mod strahytte;
        mod hotell;
        mod markedshall;
        mod smie;
        mod fjos;
        mod kirke;
        mod stall;
        mod strahus;
        mod hof;
        mod offerkapell;
        mod hytte;
        mod festning;
        mod trehytte;
        mod gjestgiveri;
        mod vatnsvei;
        mod gydingar;
    }
}

mod types {
    // mod achievement;
    mod builder;
    mod bless;
    mod building;
    mod deck;
    mod resource;
}

mod models {
    mod index;
    mod game;
    mod player;
}

mod components {
    mod initializable;
    mod signable;
    mod playable;
}

mod systems {
    mod actions;
}

#[cfg(test)]
mod tests {
    mod setup;
    mod test_setup;
}
