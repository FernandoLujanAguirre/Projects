import * as THREE from 'https://esm.sh/three@0.161.0';


function createLights(intensity,x,y,z) {
  // Create a directional light
  const light = new THREE.DirectionalLight('white', intensity);
  // move the light right, up, and towards us
  light.position.set(x, y, z);
  light.castShadow = true; // The light casts shadows
  light.shadow.mapSize.width = 2048; // Shadow map width
  light.shadow.mapSize.height = 2048; // Shadow map height
  light.shadow.bias = -0.001; // Shadow bias
  light.shadow.radius = 2; // Soft shadow blur radius

  const luz = new THREE.Group();

  luz.add(light)
  return luz;
}

export { createLights };
