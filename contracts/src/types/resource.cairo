// Core imports

use core::zeroable::Zeroable;

#[derive(Copy, Drop)]
struct Resource {
    runestone: u8,
    wood: u8,
    tools: u8,
    fur: u8,
}

#[generate_trait]
impl ResourceImpl of ResourceTrait {
    fn new(fur: u8, wood: u8, runestone: u8, tools: u8) -> Resource {
        Resource { runestone: runestone, wood: wood, tools: tools, fur: fur }
    }
}

impl ResourceZeroable of Zeroable<Resource> {
    #[inline]
    fn zero() -> Resource {
        Resource { runestone: 0, wood: 0, tools: 0, fur: 0 }
    }

    #[inline]
    fn is_zero(self: Resource) -> bool {
        self.runestone == 0 && self.wood == 0 && self.tools == 0 && self.fur == 0
    }

    #[inline]
    fn is_non_zero(self: Resource) -> bool {
        !self.is_zero()
    }
}

impl ResourceAdd of core::Add<Resource> {
    #[inline]
    fn add(lhs: Resource, rhs: Resource) -> Resource {
        Resource {
            runestone: lhs.runestone + rhs.runestone,
            wood: lhs.wood + rhs.wood,
            tools: lhs.tools + rhs.tools,
            fur: lhs.fur + rhs.fur,
        }
    }
}

impl ResourcePartialOrd of core::PartialOrd<Resource> {
    #[inline]
    fn lt(lhs: Resource, rhs: Resource) -> bool {
        lhs.runestone < rhs.runestone
            && lhs.wood < rhs.wood
            && lhs.tools < rhs.tools
            && lhs.fur < rhs.fur
    }

    #[inline]
    fn le(lhs: Resource, rhs: Resource) -> bool {
        lhs.runestone <= rhs.runestone
            && lhs.wood <= rhs.wood
            && lhs.tools <= rhs.tools
            && lhs.fur <= rhs.fur
    }

    #[inline]
    fn gt(lhs: Resource, rhs: Resource) -> bool {
        lhs.runestone > rhs.runestone
            && lhs.wood > rhs.wood
            && lhs.tools > rhs.tools
            && lhs.fur > rhs.fur
    }

    #[inline]
    fn ge(lhs: Resource, rhs: Resource) -> bool {
        lhs.runestone >= rhs.runestone
            && lhs.wood >= rhs.wood
            && lhs.tools >= rhs.tools
            && lhs.fur >= rhs.fur
    }
}

impl ResourcePartialEq of core::PartialEq<Resource> {
    #[inline]
    fn eq(lhs: @Resource, rhs: @Resource) -> bool {
        lhs.fur == rhs.fur
            && lhs.wood == rhs.wood
            && lhs.runestone == rhs.runestone
            && lhs.tools == rhs.tools
    }

    #[inline]
    fn ne(lhs: @Resource, rhs: @Resource) -> bool {
        lhs.fur != rhs.fur
            || lhs.wood != rhs.wood
            || lhs.runestone != rhs.runestone
            || lhs.tools != rhs.tools
    }
}
