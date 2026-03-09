import * as THREE from 'https://esm.sh/three@0.161.0';

function createRenderer() {
  const renderer = new THREE.WebGLRenderer({ antialias: true,preserveDrawingBuffer:false });
  renderer.physicallyCorrectLights = true;
  renderer.autoClearColor = true;
  return renderer;

}

export { createRenderer };