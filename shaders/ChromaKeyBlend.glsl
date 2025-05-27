precision highp float;

varying highp vec2 textureCoordinate;
varying highp vec2 textureCoordinate2;
            
uniform float inputThresholdSensitivity;
uniform float inputSmoothing;
uniform vec3 inputColorToReplace;
uniform vec3 inputBackgroundColor;
uniform sampler2D inputImageTexture;
uniform sampler2D inputImageTexture2;

vec4 processColor(vec4 sourceColor) {
    float colorDiff = distance(sourceColor.rgb, inputColorToReplace);
    
    float mask = 1.0 - smoothstep(
        inputThresholdSensitivity - inputSmoothing,
        inputThresholdSensitivity + inputSmoothing,
        colorDiff
    );
    
    vec3 finalColor = mix(sourceColor.rgb, inputBackgroundColor, mask);
    
    return vec4(finalColor, sourceColor.a);
}

void main()
{
    vec4 textureColor = texture2D(inputImageTexture, textureCoordinate);
    gl_FragColor = processColor(textureColor);
}