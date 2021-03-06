extends VehicleBody

var horse_power = 1600
var accel_speed = 120

var steer_angle = deg2rad(1)
var steer_speed = 1

var brake_power = 40
var brake_speed = 40

export var piloteando = false
var r_horse_power = 0

func _ready():
	if piloteando:
		$Camera.current = true
	else:
		r_horse_power = rand_range(1400,1700)
	pass
	
func _physics_process(delta):
	
	if not piloteando:
		engine_force = r_horse_power
		$TsuruVentanas.visible = true
		return
	
#	engine_force = 0
	var throt_input = (Input.get_action_strength("acelera")-Input.get_action_strength("reversa"))*horse_power
	engine_force = lerp(engine_force, throt_input, accel_speed*delta)
#	engine_force = 10048
	
	var steer_input = -Input.get_action_strength("der")+Input.get_action_strength("izq")
	steering = lerp_angle(steering, steer_input*steer_angle, steer_speed*delta)
#	steering = (-Input.get_action_strength("der")+Input.get_action_strength("izq"))*(-3)
	
	var brake_input = Input.get_action_strength("frenos")
	brake = lerp(brake, brake_input*brake_power, brake_speed*delta)
	
#	$Camera.fov = 70+(linear_velocity.length()*0.6)

#	print($llanta_d_der.get_skidinfo())
	print(linear_velocity.length())
#	print(engine_force)
