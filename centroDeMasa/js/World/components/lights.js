import * as THREE from 'https://esm.sh/three@0.161.0';

function createLights() {
  // Create a directional light
  const ambientLight = new THREE.HemisphereLight(0xddeeff, 0x202020, 9);
  let mainLight = new THREE.DirectionalLight(0xffffff, 3.0);

  // move the light right, up, and towards us
  mainLight.position.set(10,10,10);

  return [mainLight,ambientLight];
}

export { createLights };