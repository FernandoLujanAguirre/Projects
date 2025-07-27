import * as THREE from 'https://esm.sh/three@0.161.0';

function createSphere(radius,x,y,z){

    const textureLoader = new THREE.TextureLoader();
const texture = textureLoader.load("./Texturas/prueba.png");
const geometry = new THREE.SphereGeometry( radius, 32, 21 );
    

const MetalMaterial = new THREE.MeshStandardMaterial({ 
    color: 0XFF5733, 
    transparent: true, // Enable transparency
    opacity: 0.5,       // Set the opacity level (0.0 to 1.0)
    side: DoubleSide,
    wireframe:true,
    metalness: 1.0,   // between 0 and 1
    roughness: 0.5 // between 0 and 1
    
});
const material2 = new THREE.MeshBasicMaterial({ map: texture });

const sphere = new THREE.Mesh( geometry, MetalMaterial );
sphere.castShadow = true; // The cube casts a shadow
sphere.position.set(x, y, z);



return sphere
}

export {createSphere}