import { DirectionalLight, AmbientLight,HemisphereLight } from "../../../../../three.js-master/build/three.module.js";

function createLights() {
  // Create a directional light
  const ambientLight = new HemisphereLight(0xddeeff, 0x202020, 9);
  let mainLight = new DirectionalLight(0xffffff, 3.0);

  // move the light right, up, and towards us
  mainLight.position.set(10,10,10);

  return [mainLight,ambientLight];
}

export { createLights };
