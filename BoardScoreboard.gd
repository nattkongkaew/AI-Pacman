extends GridContainer

signal start_game

const SCORE_LENGTH = 6			# Number of digits for the score
const TIME_DENOMINATION = 60	# Upper limit for right time segment (60 = seconds or minutes)
const TIME_LENGTH = 2			# Number of digits in each time "segment"

var current_time
var current_score
var time_updating

onready var node_time = $Time
onready var node_score = $Score

# Initialize the scoreboard
func _ready():
	set_current_time( 0 )
	set_current_score( 0 )
#	set_time_updating( false )
	set_time_updating( false )


# Frame-by-frame updates
func _process( delta ):
	# Update time
	if time_updating:
		set_current_time( get_current_time() + delta )


# Get the current playtime
func get_current_time():
	return current_time


# Get the current score
func get_current_score():
	return current_score


# Get whether the clock is currently updating
func get_time_updating():
	return time_updating


# Set the current playtime
func set_current_time( new_time ):
	current_time = new_time
	update_time_display()


# Set the current score
func set_current_score( new_score ):
	current_score = new_score
	update_score_display()


# Set whether the time is updating
func set_time_updating( update ):
	time_updating = update


# Update the time display
func update_time_display():
	var time_string_former = "%0*d" % [TIME_LENGTH, floor( current_time / TIME_DENOMINATION )]
	var time_string_latter = "%0*d" % [TIME_LENGTH, int( floor( current_time ) ) % TIME_DENOMINATION]
	node_time.text = time_string_former + ":" + time_string_latter


# Update the score display
func update_score_display():
	var score_string = "%0*d" % [SCORE_LENGTH, current_score]
	node_score.text = score_string


# Add a score value to the total score
func add_score( score_added ):
	set_current_score( get_current_score() + score_added )


# Reset the clock to 00:00
func reset_clock():
	set_current_time( 0 )
