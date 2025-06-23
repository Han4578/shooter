#[compute]
#version 450

// Invocations in the (x, y, z) dimension
layout(local_size_x = 32, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 0, std430) restrict readonly buffer Positions {
    vec2 data[];
}
positions;


layout(set = 0, binding = 2, std430) restrict buffer Bin {
    int data[];
}
bin;


layout(set = 0, binding = 4, std430) restrict writeonly buffer Boids {
    uint data[];
}
boids;

layout(set = 0, binding = 6, std140) restrict readonly uniform BoidInfo {
    uint boid_radius;
}
boid_info;


#include "functions.glsl"

// The code we want to execute in each invocation
void main() {

    // gl_GlobalInvocationID.x uniquely identifies this invocation across all work groups
	if (gl_GlobalInvocationID.x >= positions.data.length()) return;
	int bin_index = hash(to_cell(positions.data[gl_GlobalInvocationID.x]));
	int boid_index = atomicAdd(bin.data[bin_index], -1) - 1;
	boids.data[boid_index] = gl_GlobalInvocationID.x;
}