#version 120

const bool colortex5Clear = false;

#include "/lib/math.glsl"
#include "/lib/framebuffer.glsl"

uniform int frameCounter;

varying vec2 coord;


/* DRAWBUFFERS:0 */

void main() {
    vec3 color;

    // Making every second frame black to show that indeed only
    // every second frame is beeing used

    if (fract(float(frameCounter) * 0.5) == 0) {
        color = vec3(0);
    } else {
        color = texture2D(colortex0, coord).rgb;
    }


    FD_0 = vec4(color, 1.0);
}

