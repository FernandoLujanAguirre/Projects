import { Vector2 } from "../../../../../three.js-master/build/three.module.js";
import { EffectComposer } from "../../../../../three.js-master/examples/jsm/postprocessing/EffectComposer.js";
import { RenderPass } from "../../../../../three.js-master/examples/jsm/postprocessing/RenderPass.js";
import { UnrealBloomPass} from "../../../../../three.js-master/examples/jsm/postprocessing/UnrealBloomPass.js"

RenderPass
function createPostprocessing(scene,camera, renderer){

    const renderScene = new RenderPass(scene, camera);
    const composer = new EffectComposer(renderer);
    composer.addPass(renderScene);

    const bloomPass = new UnrealBloomPass(
        new Vector2(window.innerWidth, window.innerHeight),
        4,
        0.4,
        0.85,
        );

    composer.addPass(bloomPass);

   // renderer.toneMapping = THREE.CineonToneMapping;

    return composer
    }

    export {createPostprocessing}