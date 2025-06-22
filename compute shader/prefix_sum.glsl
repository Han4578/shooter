#[compute]
#version 450

// Invocations in the (x, y, z) dimension
layout(local_size_x = 32, local_size_y = 1, local_size_z = 1) in;


layout(set = 0, binding = 2, std430) restrict readonly buffer Bin {
    int data[];
}
bin;


layout(set = 0, binding = 3, std430) restrict writeonly buffer TempBin {
    int data[];
}
temp_bin;


layout(set = 0, binding = 5, std140) restrict readonly uniform Config{
    uint prefix_offset;
}
config;


// The code we want to execute in each invocation
void main() {
   	if (gl_GlobalInvocationID.x > bin.data.length()) return;

	temp_bin.data[gl_GlobalInvocationID.x] = bin.data[gl_GlobalInvocationID.x];
	if (gl_GlobalInvocationID.x - config.prefix_offset >= 0) temp_bin.data[gl_GlobalInvocationID.x] += bin.data[gl_GlobalInvocationID.x - config.prefix_offset];
}