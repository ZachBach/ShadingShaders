varying float vNoise;
varying vec2 vUv;
uniform sampler2D oceanTexture;
uniform float time;

void main(){
    vec3 color1=vec3(.9804,.1373,.0275);
    vec3 color2=vec3(.2039,.9608,.0157);
    vec3 finalColor=mix(color1,color2,.5*(vNoise+1.));
    
    vec2 newUV=vUv;
    
    // float noise=cnoise(vec3(vUv*5.,time));
    
    newUV=vec2(newUV.x,newUV.y+.01*sin(newUV.x*10.+time));
    
    vec4 oceanView=texture2D(oceanTexture,newUV);
    
    // gl_FragColor=vec4(finalColor,1.);
    gl_FragColor=vec4(vUv,0.,1.);
    // gl_FragColor=oceanView+.5*vec4(vNoise);
    // gl_FragColor=vec4(noise);
}

// Fragment shaders are important for colors. We have to be careful about the number of colored pixels
// for performance reasons/issues. As well as UV's

// ----------------------------------------------------------------------- UV"S IMPORTANT ------------------------------------------------------------------------------------------------
// uV's are just a system of coordinates on an object to put a texture on it and just need to ad varying to our vertex to use it.and uVu is 2d vector.
// this comes from the cpu and uses the vertex of the obj.

// ------------------------------------------------------------------------ Adding a texture using an image with parcel--------------------------------------------------------------------
// First we need to import the image. We create a img folder and then will probably use uniforms to add the image to our texture.
// oceanTexture: {value: new THREE.TextureLoader().load(ocean)} like so!

// after using uniform sampler2D we need to use it using vector four. vec4 oceanView = texture2D(which takes two params);

//  then we need to use the FragColor to finally add the image to our texture.

//  Next the biggest effect you will see is to distort the vUv we can create a newUV by copying it into the new variable.
// like so vec2 newUV=vUv; newUV=vec2(newUV.x,newUV.y+newUV.x*.1);

//  then we use a small amplitutude and then use it on the x axis and multiply it by 10. and add our time to bring it to life just like a real wave.
// newUV=vec2(newUV.x,newUV.y+.01*sin(newUV.x*10.+time));

// be very careful using the cnoise as its very tasking on the CPU depending on what you are renderering. Better just to use the imported noise