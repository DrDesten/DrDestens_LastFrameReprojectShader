#version 120

#include "/lib/math.glsl"
#include "/lib/framebuffer.glsl"

#define PREVIOUS_FRAME_FALLBACK
#define HAND_FIX

uniform vec3 cameraPosition;
uniform vec3 previousCameraPosition;
uniform mat4 gbufferModelView;
uniform mat4 gbufferModelViewInverse;
uniform mat4 gbufferPreviousModelView;
uniform mat4 gbufferProjection;
uniform mat4 gbufferProjectionInverse;
uniform mat4 gbufferPreviousProjection;

uniform int frameCounter;

varying vec2 coord;

vec2 ReprojectPreviousFrame(vec2 coord, float depth) {
    #ifdef HAND_FIX
        if (depth < 0.56) { return coord; } // No Reprojection on the hand
    #endif

    //Clip space
    vec4 pos = vec4(coord, depth, 1.0) * 2.0 - 1.0;

    //View space
    pos = gbufferProjectionInverse * pos;
    pos /= pos.w;

    //World space
    pos = gbufferModelViewInverse * pos;

    //Previous position
    vec4 prev_pos = pos + vec4(cameraPosition-previousCameraPosition, 0.0);
    
    //World to view space
    prev_pos = gbufferPreviousModelView * prev_pos;
    
    //View to projection space
    prev_pos = gbufferPreviousProjection * prev_pos;

    //Projection to UV space
    prev_pos.xyz = (prev_pos.xyz / prev_pos.w) * 0.5 + 0.5;

    #ifdef HAND_FIX
        if (getDepth(prev_pos.xy) < 0.56) { return coord; } // No Reprojection to the hand / out of bounds
    #endif
    
    #ifdef PREVIOUS_FRAME_FALLBACK
        if (clamp(prev_pos.xy, 0, 1) != prev_pos.xy) { return coord; } // No Reprojection to the hand / out of bounds
    #endif
    
    return prev_pos.xy;
}

vec2 betterClamp(vec2 coord) {
    // Center at 0,0
    coord = coord - 0.5;
    // Calculate oversize vector by subtracting 1 on each axis from the absulute
    // We just need the length so sing doesnt matter
    vec2 oversize = max2(vec2(0), abs(coord) - 0.5);
    coord /= (length(oversize) + 1);
    coord = coord + 0.5;
    return coord;
}


/* DRAWBUFFERS:0 */

void main() {
    vec3 color;

    if (fract(float(frameCounter) * 0.5) == 0) {
        float depth = getDepth(coord);
        vec2 p_coord = ReprojectPreviousFrame(coord, depth);
        color = getAlbedo((p_coord));
    } else {
        color = getAlbedo_prev(coord);
    }

    gl_FragColor = vec4(color, 1.0);
}

