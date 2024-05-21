import { Group,AmbientLight,DirectionalLight } from '../../three.js-master/build/three.module.js';

function createLights(intensity,x,y,z) {
  // Create a directional light
  const light = new DirectionalLight('white', intensity);
  const ambientLight = new AmbientLight(0xffffff, 0.5); // White light with half intensity
  // move the light right, up, and towards us
  light.position.set(x, y, z);
  light.castShadow = true; // The light casts shadows
  light.shadow.mapSize.width = 2048; // Shadow map width
  light.shadow.mapSize.height = 2048; // Shadow map height
  light.shadow.bias = -0.001; // Shadow bias
  light.shadow.radius = 2; // Soft shadow blur radius

  const luz = new Group();

  luz.add(light,ambientLight)
  return luz;
}

export { createLights };
