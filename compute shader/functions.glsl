ivec2 to_cell(in vec2 coords) {
	return ivec2(floor(coords.x / boid_info.boid_radius), floor(coords.y / boid_info.boid_radius));
}


int hash(in ivec2 coords) {
	return (int(coords.x * 196613) ^ int(coords.y * 393241)) % bin.data.length();
}