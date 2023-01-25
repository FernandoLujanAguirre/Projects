import { Color, Scene } from "../../../../../three.js-master/build/three.module.js";

function createScene() {
  const scene = new Scene();

  scene.background = new Color("rgb(156, 172, 164)");

  return scene;
}

export { createScene };
