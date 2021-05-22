uniform sampler2D colortex0; // Color
uniform sampler2D colortex5; // Previous Color

uniform sampler2D depthtex0;

uniform float viewHeight;
uniform float viewWidth;


#define FD_0 gl_FragData[0]
#define FD_1 gl_FragData[1]
#define FD_2 gl_FragData[2]


vec3 getAlbedo(in vec2 coord) {
    return texture2D(colortex0, coord).rgb;
}
vec3 getAlbedo_prev(in vec2 coord) {
    return texture2D(colortex5, coord).rgb;
}


float getDepth(in vec2 coord) {
    return texture2D(depthtex0, coord).x;
}