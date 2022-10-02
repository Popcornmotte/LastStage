extends RigidBody2D

export var engineParticles : NodePath
onready var engine = get_node(engineParticles)
const detachSound = preload("res://Sounds/slidingdoor.wav")
var fuel = 100
var fire = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func start():
	$ProgressBar.visible = true
	engine.emitting = true
	fire = true
	$engineSound.play()
# Called every frame. 'delta' is the elapsed time since the previous frame.

func detach():
	add_force(Vector2(0,0),Vector2(25*rand_range(-10,10),50+rand_range(100,200)))
	add_torque(rand_range(-200,200))
	$ProgressBar.visible = false
	engine.emitting = false
	print("force added")
	$engineSound.stop()
	Audio.playSfx(detachSound)

func _process(delta):
	if fire:
		$ProgressBar.value -= 10*delta
	pass
