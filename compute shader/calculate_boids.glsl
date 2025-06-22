#[compute]
#version 450

// Invocations in the (x, y, z) dimension
layout(local_size_x = 32, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 0, std430) restrict readonly buffer Positions {
    vec2 data[];
}
positions;


layout(set = 0, binding = 1, std430) restrict writeonly buffer Results {
    vec2 data[];
}
results;


layout(set = 0, binding = 2, std430) restrict readonly buffer Bin {
    int data[];
}
bin;


layout(set = 0, binding = 4, std430) restrict readonly buffer Boids {
    int data[];
}
boids;


#include "functions.glsl"

// The code we want to execute in each invocation
void main() {

    // gl_GlobalInvocationID.x uniquely identifies this invocation across all work groups
	if (gl_GlobalInvocationID.x >= positions.data.length()) return;
	ivec2 cell = to_cell(positions.data[gl_GlobalInvocationID.x]);
	vec2 separation = vec2(0, 0);
	vec2 pos = positions.data[gl_GlobalInvocationID.x];

	for (int dy = -1; dy < 2; ++dy) {
		for (int dx = -1; dx < 2; ++dx) {
			int bin_index = hash(ivec2(cell.x + dx, cell.y + dy));
			int end = bin.data[bin_index + 1];

			for (int boid_index = bin.data[bin_index]; boid_index < end; ++boid_index) {
				uint other = boids.data[boid_index];
				vec2 other_pos = positions.data[other];

				if (other == gl_GlobalInvocationID.x) continue;

				separation -= max(0, 1 - length(other_pos - pos) / 60.0) * normalize(other_pos - pos);
			}
		}
	}

	if (length(separation) > 1) separation = normalize(separation);
	results.data[gl_GlobalInvocationID.x] = separation * 2;
}