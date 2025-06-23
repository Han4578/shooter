shader_type particles;

uniform vec2 initial_velocity;
uniform vec2 initial_position;
uniform vec2 gravity = vec2(0, 2000);

void start(){
	VELOCITY.xy = initial_velocity;
	TRANSFORM[3].xy = initial_position;
}

void process() {
	VELOCITY.xy += gravity * DELTA;
	// Called every frame on existing particles (according to the Fixed FPS property).
}
