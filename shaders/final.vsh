#version 120

uniform float viewWidth;
uniform float viewHeight;

uniform vec3 cameraPosition;
uniform vec3 previousCameraPosition;
uniform mat4 gbufferModelView;
uniform mat4 gbufferModelViewInverse;
uniform mat4 gbufferPreviousModelView;
uniform mat4 gbufferProjection;
uniform mat4 gbufferProjectionInverse;
uniform mat4 gbufferPreviousProjection;

varying vec2 coord;

vec3 toView(vec3 clipspace) {
    vec4 tmp = gbufferProjectionInverse * vec4(clipspace, 1.0);
    return tmp.xyz / tmp.w;
}

vec3 toPlayer(vec3 viewspace) {
    return mat3(gbufferModelViewInverse) * viewspace;
}

vec3 toPlayerfeet(vec3 eyeplayerspace) {
    return eyeplayerspace + gbufferModelViewInverse[3].xyz;
}

vec3 toWorld(vec3 playerfeetpos) {
    return playerfeetpos + cameraPosition;
}



void main() {
    vec4 ClipSpace = ftransform();
    /* vec3 ViewSpace = toView(ClipSpace.xyz);
    vec3 PlayerSpace = toPlayerfeet(toPlayer(ViewSpace));
    vec3 WorldSpace = toWorld(PlayerSpace);

    vec3 previousPlayerSpace = WorldSpace - previousCameraPosition - gbufferModelViewInverse[3].xyz;
    vec3 previousViewSpace = mat3(gbufferPreviousModelView) * previousPlayerSpace;
    vec4 previousClipSpace = gbufferPreviousProjection * vec4(previousViewSpace, 1.0);
    vec3 previousScreenSpace = previousClipSpace.xyz / previousClipSpace.w * 0.5 + 0.5;
 */

    gl_Position = ClipSpace;
    coord = gl_MultiTexCoord0.st;
}