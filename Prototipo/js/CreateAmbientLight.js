import { AmbientLight } from '../../three.js-master/build/three.module.js';

function createAmbientLights(intensity,x,y,z) {

const ambientLight = new AmbientLight(0xffffff, 1); // White light with half intensity

return ambientLight;
}

export { createAmbientLights };