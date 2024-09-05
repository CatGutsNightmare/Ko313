extends Line2D
class_name Trail

@export var target_path: NodePath
@export var max_points := 100
@export var resolution := 1.0
@export var lifetime := 0.5
@export var is_emitting = false : set = _set_emitting, get = _get_emitting

@onready var target: Node2D = get_node_or_null(target_path)

var _points_creation_time := []
var _clock := 0.0

var _last_point := Vector2.ZERO



func _ready() -> void:
	if not target:
		target = get_parent() as Node2D
	
	if Engine.is_editor_hint():
		set_process(false)
		return

	set_as_top_level(true)
	position = Vector2.ZERO
	clear_points()
	
	_last_point = to_local(target.global_position)



func _process(delta: float) -> void:
	_clock += delta
	remove_older()
	# Adding new points if necessary.
	var desired_point := to_local(target.global_position)
	var distance: float = _last_point.distance_to(desired_point)
	if distance > resolution:
		add_timed_point(desired_point, _clock)


func add_timed_point(point: Vector2, time: float) -> void:
	add_point(point)
	_points_creation_time.append(time)
	_last_point = point
	if get_point_count() > max_points:
		remove_first_point()


# Removes the first point in the line and the corresponding time.
func remove_first_point() -> void:
	if get_point_count() > 1:
		remove_point(0)
	_points_creation_time.pop_front()

# Remove points older than `lifetime`.
func remove_older() -> void:
	for creation_time in _points_creation_time:
		var delta = _clock - creation_time
		if delta > lifetime:
			remove_first_point()
		# Points in `_points_creation_time` are ordered from oldest to newest so as soon as a point
		# isn't older than `lifetime`, we know all remaining points should stay as well.
		else:
			break
func  _get_emitting():
	return is_emitting

func _set_emitting(emitting: bool) -> void:
	is_emitting = emitting
	
	if Engine.is_editor_hint():
		return

	if  !is_inside_tree():
		await owner.ready

	if is_emitting:
		clear_points()
		_points_creation_time.clear()
		_last_point = to_local(target.global_position)

func _get_configuration_warning() -> String:
	var warning := "Missing Target node: assign a Node that extends Node2D in the Target Path or make the trail a child of a parent that extends Node2D"
	if target:
		warning = ""
	return warning
