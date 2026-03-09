import { Color, Scene } from 'https://esm.sh/three@0.161.0';

function createScene() {
  const scene = new Scene();

  scene.background = new Color(0xffffff);

  return scene;
}

export { createScene };
