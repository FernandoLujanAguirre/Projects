import { DirectionalLight, AmbientLight } from "../../../../../three.js-master/build/three.module.js";

function createLights() {
  // Create a directional light
  const light = new DirectionalLight('white', 20);
  const ambientLight = new AmbientLight('red', 1);

  // move the light right, up, and towards us
  light.position.set(10,10,10);

  return [light,ambientLight];
}

export { createLights };
