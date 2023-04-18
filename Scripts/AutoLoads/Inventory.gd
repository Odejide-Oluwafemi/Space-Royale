extends Node

var objectScenes: = {
	"Ship":{
		"NightHawk": preload("res://Scenes/Ships/NightHawk.tscn"),
		"Destroyer": preload("res://Scenes/Ships/Destroyer.tscn"),
		"BlueDevil": preload("res://Scenes/Ships/BlueDevil.tscn"),
	},
	"Bullet": {
		"NailBullet": preload("res://Scenes/Bullets/NailBullet.tscn"),
	},
	"Weapon": {
		"Primary": {
			"GatlingGun": preload("res://Scenes/Weapons/GatlingGun.tscn"),
		},
	},
}
#var resourceData: = {
#	"Armor" : {
#		"BasicArmor": preload("res://Resources/Common/Armor/BasicArmor.tres"),
#	},
#	"Engine": {
#		"BasicEngine": preload("res://Resources/Common/Engine/BasicEngine.tres"),
#	},
#	"Bullet": {
#		"NailBullet": preload("res://Resources/Common/Bullet/NailBullet.tres"),
#	},
#	"Weapon": {
#		"Primary": {
#			"GatlingGun": preload("res://Resources/Common/Weapon/GatlingGun.tres"),
#		},
#	},
#	"WeaponSystem": {
#		"BasicWeaponSystem": preload("res://Resources/Common/WeaponSystem/BasicWeaponSystem.tres"),
#	},
#}

#var abstractScenes: = {
#	"Engine": preload("res://Scenes/Abstracts/Engine.tscn"),
#	"Armor" : preload("res://Scenes/Abstracts/Armor.tscn"),
#	"Weapon": preload("res://Scenes/Abstracts/Weapon.tscn"),
#	"WeaponSystem": preload("res://Scenes/Abstracts/WeaponSystem.tscn"),
#}

var aiScript = load("res://Scripts/Abstracts/AI.gd")
var playerScript = load("res://Scripts/Abstracts/Player.gd")

var ais: = [
	preload("res://Scenes/Ships/AIs/AI_1.tscn")
]
