layout(set = 0, binding = 0, std430) restrict buffer Positions {
    vec2 data[];
}
positions;


layout(set = 0, binding = 1, std430) restrict buffer Results {
    vec2 data[];
}
results;


layout(set = 0, binding = 2, std430) restrict buffer Bin {
    int data[];
}
bin;


layout(set = 0, binding = 3, std430) restrict buffer TempBin {
    int data[];
}
temp_bin;


layout(set = 0, binding = 4, std430) restrict buffer Boids {
    uint data[];
}
boids;


layout(set = 0, binding = 5, std140) restrict buffer Config{
    uint data[];
}
config;
