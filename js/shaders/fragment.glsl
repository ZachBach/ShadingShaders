varying float vNoise;

void main(){
    vec3 color1=vec3(.9804,.1373,.0275);
    vec3 color2=vec3(.2039,.9608,.0157);
    vec3 finalColor=mix(color1,color2,.5*(vNoise+1.));
    
    gl_FragColor=vec4(finalColor,1.);
}