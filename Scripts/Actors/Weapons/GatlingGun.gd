extends PrimaryWeapon

func shoot():
	if isReloading() :
		return
	if ammoInGun <= 0 and not isReloading():
		if ammoAtHand > 0:
			reload()
		else:
			emit_signal("ammo_depleted")
		return
	var bullet: = ((data as WeaponResource).BulletScene as PackedScene).instance() as Bullet
	ship.shoot_bullet(bullet)
	ammoInGun -= ammoExpendAmount
	 
