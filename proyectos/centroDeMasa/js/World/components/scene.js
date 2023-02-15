import { Color, Scene } from "../../../../../three.js-master/build/three.module.js";

function createScene() {
  const scene = new Scene();

  scene.background = new Color("rgb(0,0, 0)");

  return scene;
}

export { createScene };
