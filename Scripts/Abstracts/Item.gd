extends Resource

class_name Item

enum ItemRarity {
	Common,
	Rare,
	Epic,
	Legendary
}

export(ItemRarity) var Rarity
export(bool)       var IsUnlocked = false
