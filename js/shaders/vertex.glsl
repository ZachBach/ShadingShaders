//	Classic Perlin 3D Noise
//	by Stefan Gustavson
//
vec4 permute(vec4 x){return mod(((x*34.)+1.)*x,289.);}
vec4 taylorInvSqrt(vec4 r){return 1.79284291400159-.85373472095314*r;}
vec3 fade(vec3 t){return t*t*t*(t*(t*6.-15.)+10.);}

float cnoise(vec3 P){
    vec3 Pi0=floor(P);// Integer part for indexing
    vec3 Pi1=Pi0+vec3(1.);// Integer part + 1
    Pi0=mod(Pi0,289.);
    Pi1=mod(Pi1,289.);
    vec3 Pf0=fract(P);// Fractional part for interpolation
    vec3 Pf1=Pf0-vec3(1.);// Fractional part - 1.0
    vec4 ix=vec4(Pi0.x,Pi1.x,Pi0.x,Pi1.x);
    vec4 iy=vec4(Pi0.yy,Pi1.yy);
    vec4 iz0=Pi0.zzzz;
    vec4 iz1=Pi1.zzzz;
    
    vec4 ixy=permute(permute(ix)+iy);
    vec4 ixy0=permute(ixy+iz0);
    vec4 ixy1=permute(ixy+iz1);
    
    vec4 gx0=ixy0/7.;
    vec4 gy0=fract(floor(gx0)/7.)-.5;
    gx0=fract(gx0);
    vec4 gz0=vec4(.5)-abs(gx0)-abs(gy0);
    vec4 sz0=step(gz0,vec4(0.));
    gx0-=sz0*(step(0.,gx0)-.5);
    gy0-=sz0*(step(0.,gy0)-.5);
    
    vec4 gx1=ixy1/7.;
    vec4 gy1=fract(floor(gx1)/7.)-.5;
    gx1=fract(gx1);
    vec4 gz1=vec4(.5)-abs(gx1)-abs(gy1);
    vec4 sz1=step(gz1,vec4(0.));
    gx1-=sz1*(step(0.,gx1)-.5);
    gy1-=sz1*(step(0.,gy1)-.5);
    
    vec3 g000=vec3(gx0.x,gy0.x,gz0.x);
    vec3 g100=vec3(gx0.y,gy0.y,gz0.y);
    vec3 g010=vec3(gx0.z,gy0.z,gz0.z);
    vec3 g110=vec3(gx0.w,gy0.w,gz0.w);
    vec3 g001=vec3(gx1.x,gy1.x,gz1.x);
    vec3 g101=vec3(gx1.y,gy1.y,gz1.y);
    vec3 g011=vec3(gx1.z,gy1.z,gz1.z);
    vec3 g111=vec3(gx1.w,gy1.w,gz1.w);
    
    vec4 norm0=taylorInvSqrt(vec4(dot(g000,g000),dot(g010,g010),dot(g100,g100),dot(g110,g110)));
    g000*=norm0.x;
    g010*=norm0.y;
    g100*=norm0.z;
    g110*=norm0.w;
    vec4 norm1=taylorInvSqrt(vec4(dot(g001,g001),dot(g011,g011),dot(g101,g101),dot(g111,g111)));
    g001*=norm1.x;
    g011*=norm1.y;
    g101*=norm1.z;
    g111*=norm1.w;
    
    float n000=dot(g000,Pf0);
    float n100=dot(g100,vec3(Pf1.x,Pf0.yz));
    float n010=dot(g010,vec3(Pf0.x,Pf1.y,Pf0.z));
    float n110=dot(g110,vec3(Pf1.xy,Pf0.z));
    float n001=dot(g001,vec3(Pf0.xy,Pf1.z));
    float n101=dot(g101,vec3(Pf1.x,Pf0.y,Pf1.z));
    float n011=dot(g011,vec3(Pf0.x,Pf1.yz));
    float n111=dot(g111,Pf1);
    
    vec3 fade_xyz=fade(Pf0);
    vec4 n_z=mix(vec4(n000,n100,n010,n110),vec4(n001,n101,n011,n111),fade_xyz.z);
    vec2 n_yz=mix(n_z.xy,n_z.zw,fade_xyz.y);
    float n_xyz=mix(n_yz.x,n_yz.y,fade_xyz.x);
    return 2.2*n_xyz;
}

uniform float time;
varying float vNoise;
varying vec2 vUv;

void main(){
    vec3 newposition=position;
    float PI=3.1415925;
    float noise=cnoise(10.*(vec3(position.x,position.y,position.z)));
    // newposition.z+=.1*sin((newposition.x+.25+time/10.)*2.*PI);
    // newposition.z+=.2*noise;
    // float dist=distance(position,vec2(.5));
    
    // newposition.z+=.05*sin(dist*40.);
    
    vNoise=noise;
    vUv=uv;
    
    gl_Position=projectionMatrix*modelViewMatrix*vec4(newposition,1.);
}

// Position is the coordinates in a 3d space vec 3 is basically for 3d space coordinates.

// We can add the x, y , z coordinates here.
// the vertex shader is all about the posistion of the object in a 3d space. and this applys to each of the points
// on the planebuffer geo and to animate it we would need time. Using the vertex though is how we can distort the 3d
// object. newposition.y+=.1*sin(newposition.x*20.); cool little effect for later maybe.

//  newposition.z+=.5*sin(newposition.x*20.); For a cool z distortion for my portfolio!

// Next we can add some more vertices to our planebufferGeo or points to our plane.

// Using PERLIN Noise algorithms for GLSL we can use it to distort are images by adding noise.
// Perlin uses one giant function called cnoise and instead of the sin function we were just using
// lets try it with cnoise. First we need a three dimensional vector.(vec3(three arguments for x y z axis))
// looks very similar to sign but these values are too small to see any significant change.
//   newposition.z+=cnoise(vec3(position.x*10.,position.y*10.,0.)); <- like so

// I need to get more familiar with the sin function itself as it is very important to shaders.
// especially using the number PI so now its between 0-1 for x and then we times it by 0.5ish
//     float PI=3.1415925;
// newposition.z+=.1*sin((newposition.x+.25)*2.*PI); is very useful for an exact arch using PI.
// the sine function is exactly between 0 and PI.

// vertex is ran on the gpu and the javascript on the cpu.
//  we imported uniform float for our time from our js and then we added it to our sine function and then divided it by 10 points
// Now we are left with a beautiful wave like animation. ex. newposition.z+=.1*sin((newposition.x+.25+time/10.)*2.*PI);