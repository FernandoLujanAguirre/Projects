import {GLTFLoader} from "../../three.js-master/examples/jsm/loaders/GLTFLoader.js"

function importGLTF(Archive, scene) {

    const loader = new GLTFLoader().setPath( 'Modelos_GLTF/' );
loader.load( Archive, async function ( gltf ) {    
    let model = gltf.scene;
    // wait until the model can be added to the scene without blocking due to shader compilation
    //await renderer.compileAsync( model, camera, scene );
    scene.add(model)
    
} )

}
export {importGLTF}