//precision highp float;
//varying vec2 v_texcoord;
//uniform sampler2D tex;
//
//#define STRENGTH 0.0027
//
//void main() {
//    vec2 center = vec2(0.5, 0.5);
//    vec2 offset = (v_texcoord - center) * STRENGTH;
//
//    float rSquared = dot(offset, offset);
//    float distortion = 1.0 + rSquared;
//
//    vec2 distortedOffset = offset * distortion;
//    vec2 distortedCoord = v_texcoord + distortedOffset;
//
//    // Barrel distortion warping
//    vec2 tc = distortedCoord;
//
//    // More warping to simulate CRT curvature
//    float dx = abs(0.5 - tc.x);
//    float dy = abs(0.5 - tc.y);
//    dx *= dx;
//    dy *= dy;
//
//    tc.x -= 0.5;
//    tc.x *= 1.0 + (dy * 0.03);
//    tc.x += 0.5;
//
//    tc.y -= 0.5;
//    tc.y *= 1.0 + (dx * 0.03);
//    tc.y += 0.5;
//
//    // Chromatic aberration
//    vec2 redOffset = distortedOffset * 1.02;
//    vec2 blueOffset = -distortedOffset * 1.02;
//
//    vec4 red = texture2D(tex, clamp(tc + redOffset, 0.0, 1.0));
//    vec4 green = texture2D(tex, clamp(tc, 0.0, 1.0));
//    vec4 blue = texture2D(tex, clamp(tc + blueOffset, 0.0, 1.0));
//
//    vec4 finalColor = vec4(red.r, green.g, blue.b, 1.0);
//
//    // Scanlines
//    finalColor.rgb += sin(tc.y * 1250.0) * 0.02;
//
//    // Cutoff
//    if (tc.x < 0.0 || tc.x > 1.0 || tc.y < 0.0 || tc.y > 1.0) {
//        finalColor = vec4(0.0);
//    }
//
//    gl_FragColor = finalColor;
//}

precision highp float;
varying vec2 v_texcoord;
uniform sampler2D tex;

#define STRENGTH 0.0027            // Barrel distortion strength
#define BLOOM_RADIUS 1.0 / 1000.0   // Was 1.5 / 800.0 — smaller blur
#define BLOOM_INTENSITY 0.12        // Was 0.25 — half glow
#define ABERRATION_SCALE 1.01       // Was 1.02 — tighter RGB alignment
#define SCANLINE_INTENSITY 0.012    // Slightly less interference
#define SCANLINE_FREQ 1250.0
#define VIGNETTE_STRENGTH 0.15

void main() {
    vec2 center = vec2(0.5, 0.5);
    vec2 offset = (v_texcoord - center) * STRENGTH;
    float rSquared = dot(offset, offset);
    float distortion = 1.0 + rSquared;

    vec2 distortedOffset = offset * distortion;
    vec2 tc = v_texcoord + distortedOffset;

    // CRT curvature warping
    float dx = abs(0.5 - tc.x);
    float dy = abs(0.5 - tc.y);
    dx *= dx;
    dy *= dy;

    tc.x -= 0.5;
    tc.x *= 1.0 + (dy * 0.03);
    tc.x += 0.5;

    tc.y -= 0.5;
    tc.y *= 1.0 + (dx * 0.03);
    tc.y += 0.5;

    // Chromatic aberration offsets
    vec2 redOffset = distortedOffset * ABERRATION_SCALE;
    vec2 blueOffset = -distortedOffset * ABERRATION_SCALE;

    vec4 red = texture2D(tex, clamp(tc + redOffset, 0.0, 1.0));
    vec4 green = texture2D(tex, clamp(tc, 0.0, 1.0));
    vec4 blue = texture2D(tex, clamp(tc + blueOffset, 0.0, 1.0));

    vec4 color = vec4(red.r, green.g, blue.b, 1.0);

    // Apply scanlines
    color.rgb += sin(tc.y * SCANLINE_FREQ) * SCANLINE_INTENSITY;

    // Simple bloom from bright areas
    vec3 bloom = vec3(0.0);
    float weight = 0.0;
    for (int x = -1; x <= 1; x++) {
        for (int y = -1; y <= 1; y++) {
            vec2 offset = vec2(float(x), float(y)) * BLOOM_RADIUS;
            vec3 sample = texture2D(tex, clamp(tc + offset, 0.0, 1.0)).rgb;
            float brightness = dot(sample, vec3(0.299, 0.587, 0.114));
            if (brightness > 0.8) {
                bloom += sample;
                weight += 1.0;
            }
        }
    }
    if (weight > 0.0) {
        bloom /= weight;
        color.rgb += bloom * BLOOM_INTENSITY;
    }

    // Soft vignette
    float vignette = smoothstep(0.8, 0.2, distance(tc, center));
    color.rgb *= mix(1.0, 1.0 - VIGNETTE_STRENGTH, vignette);

    // Cutoff if outside bounds
    if (tc.x < 0.0 || tc.x > 1.0 || tc.y < 0.0 || tc.y > 1.0) {
        color = vec4(0.0);
    }

    gl_FragColor = color;
}

