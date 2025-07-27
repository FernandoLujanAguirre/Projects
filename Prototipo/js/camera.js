import * as THREE from 'https://esm.sh/three@0.161.0';
function createCamera(x,y,z) {
  const camera = new THREE.PerspectiveCamera(
    35, // fov = Field Of View
    1, // aspect ratio (dummy value)
    0.1, // near clipping plane
    100, // far clipping plane
  );

  // move the camera back so we can view the scene
  camera.position.set(x, y, z);
  camera.up.set(0,0,1);
  return camera;
}

export { createCamera };
