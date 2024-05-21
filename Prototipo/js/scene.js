import { Color, Scene } from '../../three.js-master/build/three.module.js';

function createScene() {
  const scene = new Scene();

  scene.background = new Color(0xe4dfdf);

  return scene;
}

export { createScene };
