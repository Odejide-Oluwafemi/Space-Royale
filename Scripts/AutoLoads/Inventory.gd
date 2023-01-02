extends Node

var objectScenes: = {
	"Ship": [preload("res://Scenes/Ships/NightHawk.tscn")],
	"Bullet": [preload("res://Scenes/Bullets/NailBullet.tscn")],
	"Weapon": {
		"Primary": [preload("res://Scenes/Weapons/GatlingGun.tscn")],
	},
}
var resourceData: = {
	"Armor" : [preload("res://Resources/Common/Armor/BasicArmor.tres")],
	"Engine": [preload("res://Resources/Common/Engine/BasicEngine.tres")],
	"Ship"  : [preload("res://Resources/Epic/Ship/NightHawk.tres")],
	"Bullet": [preload("res://Resources/Common/Bullet/NailBullet.tres")],
	"Weapon": {
		"Primary": [preload("res://Resources/Common/Weapon/GatlingGun.tres")],
	},
	"WeaponSystem": [preload("res://Resources/Common/WeaponSystem/BasicWeaponSystem.tres")],
}

var abstractScenes: = {
	"Engine": preload("res://Scenes/Abstracts/Engine.tscn"),
	"Armor" : preload("res://Scenes/Abstracts/Armor.tscn"),
	"Weapon": preload("res://Scenes/Abstracts/Weapon.tscn"),
	"WeaponSystem": [preload("res://Scenes/Abstracts/WeaponSystem.tscn")],
}
