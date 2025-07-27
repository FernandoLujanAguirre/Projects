import * as THREE from 'https://esm.sh/three@0.161.0';

function createCamera() {
  let aspect = window.innerWidth/innerHeight;
  const camera = new THREE.PerspectiveCamera(
    35, // fov = Field Of View
    aspect, // aspect ratio (dummy value)
    0.1, // near clipping plane
    200, // far clipping plane
  );

  // move the camera back so we can view the scene
  const iso = 3.5;
  camera.position.set(2,2,4);
  camera.up.set(0,0,1);
  return camera;
}

export { createCamera };