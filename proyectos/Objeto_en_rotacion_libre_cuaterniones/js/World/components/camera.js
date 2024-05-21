import { PerspectiveCamera } from "../../../../../three.js-master/build/three.module.js";

function createCamera() {
  const camera = new PerspectiveCamera(
    10, // fov = Field Of View
    1, // aspect ratio (dummy value)
    0.1, // near clipping plane
    700, // far clipping plane
  );

  // move the camera back so we can view the scene
  const long = 500;
  camera.position.set(long,long,long);
  camera.up.set(0,0,1);
  return camera;
}

export { createCamera };