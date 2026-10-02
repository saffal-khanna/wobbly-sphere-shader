uniform float uTime;
uniform float uPositionFrequency;
uniform float uTimeFrequency;
uniform float uStrength;
uniform float uWarpPositionFrequency;
uniform float uWarpTimeFrequency;
uniform float uWarpStrength;

attribute vec4 tangent;

// varying vec2 vUv;
varying float vWobble;

#include ../includes/simplexNoise4d.glsl;

float getWobble(vec3 position) {
    vec3 warpedPosition = position;
    
    warpedPosition += simplexNoise4d(vec4(
        warpedPosition * uWarpPositionFrequency,
        uTime * uWarpTimeFrequency
    )) * uWarpStrength;

    return simplexNoise4d(vec4(
        warpedPosition * uPositionFrequency,
        uTime * uTimeFrequency
    )) * uStrength;
}

void main() {
    vec3 biTangent = cross(normal, tangent.xyz);

    // Neighbour's position
    float shift = 0.01;
    vec3 positionA = csm_Position + tangent.xyz * shift;
    vec3 positionB = csm_Position + biTangent * shift;

    // Experiments
    // csm_Position.y += sin(csm_Position.x * 5.0) * 0.25;
    // vUv = uv;

    // Wobble
    float wobble = getWobble(csm_Position);
    float positionAWobble = getWobble(positionA);
    float positionBWobble = getWobble(positionB);

    csm_Position += wobble * normal;
    positionA += positionAWobble * normal;
    positionB += positionBWobble * normal;

    vec3 toA = normalize(positionA - csm_Position);
    vec3 toB = normalize(positionB - csm_Position);

    csm_Normal = cross(toA, toB);

    // Varyings
    vWobble = wobble / uStrength;
}