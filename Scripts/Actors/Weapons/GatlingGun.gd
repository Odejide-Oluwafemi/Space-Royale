extends PrimaryWeapon

func shoot():
	if isReloading():
		return
	
	if ammoInGun <= 0:
		if hasAmmo():
			reload()
		else:
			emit_signal("ammo_depleted")
		return
	
	var bullet: = (bullet_scene as PackedScene).instance() as Bullet
	ship.shoot_bullet(bullet)
	.shoot()
	ammoInGun -= ammoExpendAmount
	canShoot = false
