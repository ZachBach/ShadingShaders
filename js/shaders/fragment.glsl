varying float vNoise;
varying vec2 vUv;

void main(){
    vec3 color1=vec3(.9804,.1373,.0275);
    vec3 color2=vec3(.2039,.9608,.0157);
    vec3 finalColor=mix(color1,color2,.5*(vNoise+1.));
    
    gl_FragColor=vec4(finalColor,1.);
    gl_FragColor=vec4(vUv,0.,1.);
}

// Fragment shaders are important for colors. We have to be careful about the number of colored pixels
// for performance reasons/issues. As well as UV's

// ----------------------------------------------------------------------- UV"S IMPORTANT ------------------------------------------------------------------------------------------------
// uV's are just a system of coordinates on an object to put a texture on it and just need to ad varying to our vertex to use it.and uVu is 2d vector.
// this comes from the cpu and uses the vertex of the obj.

// ------------------------------------------------------------------------ Adding a texture using an image with parcel--------------------------------------------------------------------
// First we need to import the image. We create a img folder and then will probably use uniforms to add the image to our texture.
// oceanTexture: {value: new THREE.TextureLoader().load(ocean)} like so!