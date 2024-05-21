import { Vector3 } from "../../../../../three.js-master/build/three.module.js";
import { GLTFLoader } from "../../../../../three.js-master/examples/jsm/loaders/GLTFLoader.js";
import { setupModel } from "./setupmodel.js";
import { MathUtils } from "../../../../../three.js-master/build/three.module.js";
async function loadObject() {

const loader = new GLTFLoader();
const [modelData] = await Promise.all([loader.loadAsync("./models/roselle_composition_book.glb")]);
const parrot = setupModel(modelData);

//parrot.rotation.set(MathUtils.degToRad(0),MathUtils.degToRad(-90),MathUtils.degToRad(90.572958));

return {parrot}


}


export { loadObject };