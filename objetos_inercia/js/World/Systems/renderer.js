import { WebGLRenderer } from 'https://esm.sh/three@0.161.0';

function createRenderer() {
  const renderer = new WebGLRenderer({ antialias: true,preserveDrawingBuffer:false });
  renderer.physicallyCorrectLights = true;
  renderer.autoClearColor = true;
  renderer.gammaOutput = false;
  renderer.gammaFactor = 2.2;
  return renderer;

}

export { createRenderer };