#version 120

const bool colortex5Clear = false;

#include "/lib/math.glsl"
#include "/lib/framebuffer.glsl"

varying vec2 coord;


/* DRAWBUFFERS:05 */

void main() {
    // Swap color from previous frame into current frame buffer
    // Swap color into previous frame buffer for next frame

    vec3 CurrentColor = texture2D(colortex0, coord).rgb;
    vec3 PreviousColor = texture2D(colortex5, coord).rgb;

    FD_0 = vec4(PreviousColor, 1.0);
    FD_1 = vec4(CurrentColor, 1.0);
}

