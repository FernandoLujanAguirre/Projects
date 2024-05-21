import { DoubleSide,MeshBasicMaterial,SphereGeometry,MeshPhongMaterial,Mesh,TextureLoader,MeshStandardMaterial } from "../../../../../three.js-master/build/three.module.js";

function createSphere(radius,x,y,z){

    const textureLoader = new TextureLoader();
const texture = textureLoader.load("./Texturas/prueba.png");
const geometry = new SphereGeometry( radius, 64, 64 );
const material1 = new MeshStandardMaterial({ 
    color: 0X4b55f5, 
    transparent: true, // Enable transparency
    opacity: 0.9,       // Set the opacity level (0.0 to 1.0)
    side: DoubleSide,
    wireframe:false,
    metalness: 1.0,   // between 0 and 1
    roughness: 0.5, // between 0 and 1
    
});

const material2 = new MeshBasicMaterial({ map: texture });

const sphere = new Mesh( geometry, material2 );
sphere.castShadow = true; // The cube casts a shadow
sphere.position.set(x, y, z);



return sphere
}

export {createSphere}