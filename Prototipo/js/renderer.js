import { WebGLRenderer } from '../../three.js-master/build/three.module.js';

function createRenderer() {
  const renderer = new WebGLRenderer({ antialias: true,preserveDrawingBuffer:false });
  renderer.physicallyCorrectLights = true;
  renderer.autoClearColor = true;
  renderer.gammaOutput = false;
  renderer.gammaFactor = 2.2;
  renderer.shadowMap.enabled = true;
  return renderer;

}

export { createRenderer };
