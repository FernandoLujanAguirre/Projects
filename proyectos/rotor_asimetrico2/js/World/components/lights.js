import { DirectionalLight, AmbientLight,HemisphereLight,SpotLight, TextureLoader, SpotLightHelper } from "../../../../../three.js-master/build/three.module.js";

function createLights() {
  // Create a directional light
  const ambientLight = new HemisphereLight(0xddeeff, 0xF7C04A, 2);
  let mainLight = new DirectionalLight(0xffffff, 2);

  // move the light right, up, and towards us
  mainLight.position.set(0,0,10);


  //////
const spotLight = new SpotLight( 0xffffff );

spotLight.position.set( 2000, 2000, 2000 );
//spotLight.map = new TextureLoader().load( url );
spotLight.intensity=10;
spotLight.castShadow = true;
spotLight.angle = .4;
spotLight.distance =20 ;

//spotLight.shadow.mapSize.width = 1024;
//spotLight.shadow.mapSize.height = 1024;

//spotLight.shadow.camera.near = .2;
//spotLight.shadow.camera.far = 50;
//spotLight.shadow.camera.fov = 1;
const spotLightHelper = new SpotLightHelper( spotLight );
  return [mainLight,ambientLight,spotLight,spotLightHelper];
}

export { createLights };
