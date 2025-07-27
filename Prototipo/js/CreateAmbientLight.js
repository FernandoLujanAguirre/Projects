import * as THREE from 'https://esm.sh/three@0.161.0';function createAmbientLights(intensity,x,y,z) {

const ambientLight = new THREE.AmbientLight(0xffffff, 1); // White light with half intensity

return ambientLight;
}

export { createAmbientLights };