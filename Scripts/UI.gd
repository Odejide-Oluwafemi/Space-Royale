extends Control

export(NodePath) var BattleGroundNode

export(NodePath) var HealthLabelNode
export(NodePath) var ArmorLabelNode
export(NodePath) var KillsLabelNode

export(NodePath) var PrimaryWeaponThumbnailNode
export(NodePath) var PrimaryWeaponAmmoInGunLabelNode
export(NodePath) var PrimaryWeaponAmmoInHandLabelNode

export(NodePath) var SecondaryWeaponThumbnailNode
export(NodePath) var SecondaryWeaponAmmoLabelNode

export(NodePath) var SpecialSkillProgressBarNode

onready var battleground: = get_node(BattleGroundNode) as Node2D

onready var healthLabel: = get_node(HealthLabelNode) as Label
onready var armorLabel: = get_node(ArmorLabelNode) as Label
onready var killsLabel: = get_node(KillsLabelNode) as Label

onready var pWeaponThumbnail: = get_node(PrimaryWeaponThumbnailNode) as TextureRect
onready var pWeaponAmmoInGunLabel: = get_node(PrimaryWeaponAmmoInGunLabelNode) as Label
onready var pWeaponAmmoInHandLabel: = get_node(PrimaryWeaponAmmoInHandLabelNode) as Label

onready var sWeaponThumbnail: = get_node(SecondaryWeaponThumbnailNode) as TextureRect
onready var sWeaponAmmoLabel: = get_node(SecondaryWeaponAmmoLabelNode) as Label

onready var specialSkillProgressBar: = get_node(SpecialSkillProgressBarNode) as TextureProgress

func updateLabel(node: Label, value: int):
	node.text = str(value) if value != null else "-"

func setTexture(node: TextureRect, value: Texture):
	node.texture = value

func setProgessBarTextures(node: TextureProgress, underTexture: Texture, overTexture: Texture, progressTexture: Texture, shouldStretch: = true):
	node.texture_under = underTexture
	node.texture_over = overTexture
	node.texture_progress = progressTexture
	node.nine_patch_stretch = shouldStretch

func setProgessBarColors(node: TextureProgress, underTint: Color, overTint: Color, progressTint: Color):
	node.tint_under = underTint
	node.tint_over = overTint
	node.tint_progress = progressTint

func setProgressBarValues(node: TextureProgress, value: float, min_value: float, max_value: float):
	node.value = value
	node.min_value = min_value
	node.max_value = max_value

func updateStats(ship: Ship):
	if not ship:
		return
	var pWeapon: PrimaryWeapon
	
	for weapon in ship.weaponSystem.primaryWeapons:
		if weapon.isActive:
			pWeapon = weapon
			break
	
	if not pWeapon:
		return
	
	updateLabel(healthLabel, ship.durability)
	updateLabel(armorLabel, ship.armor.armor)
	updateLabel(killsLabel, 0)
	updateLabel(pWeaponAmmoInGunLabel, pWeapon.ammoInGun)
	updateLabel(pWeaponAmmoInHandLabel, pWeapon.ammoAtHand)
	setTexture(pWeaponThumbnail, pWeapon.data.Thumbnail)
	updateLabel(sWeaponAmmoLabel, 0)
