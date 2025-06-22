ivec2 to_cell(in vec2 coords) {
	return ivec2(floor(coords.x / 60), floor(coords.y / 60));
}


int hash(in ivec2 coords) {
	return (int(coords.x * 196613) ^ int(coords.y * 393241)) % bin.data.length();
}