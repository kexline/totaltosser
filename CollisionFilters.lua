--Collision filters

local CollisionFilters = {};

CollisionFilters.trash = { categoryBits=1, maskBits=106};
CollisionFilters.bin = { categoryBits=2, maskBits=21};
CollisionFilters.laundry = { categoryBits=4, maskBits=106};
CollisionFilters.basket = { categoryBits=8, maskBits=21};
CollisionFilters.toy ={categoryBits=16,maskBits=106};
CollisionFilters.box = { categoryBits=32, maskBits=21};
CollisionFilters.walls = { categoryBits=64, maskBits=21}

return CollisionFilters;