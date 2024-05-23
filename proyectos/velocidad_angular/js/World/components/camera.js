import { PerspectiveCamera } from "../../../../../three.js-master/build/three.module.js";

function createCamera() {
  let aspect = window.innerWidth/innerHeight;
  const camera = new PerspectiveCamera(
    35, // fov = Field Of View
    aspect, // aspect ratio (dummy value)
    0.1, // near clipping plane
    200, // far clipping plane
  );

  // move the camera back so we can view the scene
  const iso = 3.5;
  camera.position.set(5,5,10);
  camera.up.set(0,0,1);
  return camera;
}

export { createCamera };