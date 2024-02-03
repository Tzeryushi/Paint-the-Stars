class_name MagicStar
extends Node2D

##magic star will send out a signal when it encounters a path that is close to it
##it will grow larger and shine in this event, and will cease doing so on command
@export_range(0, 20) var star_number : int = 0 
@export var star_sprite : Sprite2D

@onready var spin_speed = randf_range(-0.5,0.5)

const SMALL_STAR_SCALE = Vector2(0.5, 0.5)
const MED_STAR_SCALE = Vector2(0.75, 0.75)
const LARGE_STAR_SCALE = Vector2(1.35, 1.35)

var is_activated : bool = false
var is_pathing : bool = false

signal path_encountered(number:int)

func _ready() -> void:
	scale = SMALL_STAR_SCALE

func _physics_process(_delta) -> void:
	star_sprite.rotation += spin_speed*0.1

##activate grows the star and spins it faster
func activate() -> void:
	is_activated = true
	scale = LARGE_STAR_SCALE
	path_encountered.emit(star_number)
	pass

func deactivate() -> void:
	is_activated = false
	pass

func grow_visible() -> void:
	scale = MED_STAR_SCALE

func shrink_visible() -> void:
	scale = SMALL_STAR_SCALE

func start_pathing() -> void:
	scale = Vector2.ONE
	is_pathing = true

func end_pathing() -> void:
	is_pathing = false
	scale = MED_STAR_SCALE

func _on_collection_area_mouse_entered():
	#if pathing active, activate
	if is_pathing and !is_activated:
		activate()
