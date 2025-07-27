import * as THREE from 'https://esm.sh/three@0.161.0';

function createScene() {
  const scene = new THREE.Scene();

  scene.background = new THREE.Color(0x243763);

  return scene;
}

export { createScene };
