uniform vec3 uColorA;
uniform vec3 uColorB;

// varying vec2 vUv;
varying float vWobble;

void main() {
    float colorMix = smoothstep(-1.0, 1.0, vWobble);
    csm_DiffuseColor.rgb = mix(uColorA, uColorB, colorMix);
    
    // Mirror step
    // csm_Metalness = step(0.25, vWobble);
    // csm_Metalness = smoothstep(0.25, 1.0, vWobble);
    // csm_Roughness = 1.0 - csm_Metalness;

    csm_Roughness = 1.0 - vWobble;

    // Creating a black sphere based on vWobble's strength
    // csm_FragColor.rgb = vec3(vWobble);

    // Experiments
    // csm_FragColor = vec4(1.0, 0.5, 0.5, 1.0);
    // csm_DiffuseColor = vec4(1.0, 0.5, 0.5, 1.0);
    // csm_Metalness = step(0.0, sin(vUv.x * 100.0 + 0.5));
}