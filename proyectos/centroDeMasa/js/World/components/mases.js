import * as THREE from 'https://esm.sh/three@0.161.0';

function createMases(){
    let theta = 0;
const l1 = 1;
const geometry = new THREE.SphereGeometry( 0.1, 64, 32 );
const material1 = new THREE.MeshBasicMaterial( { color: 0xFB8B24 } );
const material2 = new THREE.MeshBasicMaterial( { color: 0xD90368 } );
const material3 = new THREE.MeshBasicMaterial( { color: 0x084887 } );
const material4 = new THREE.MeshBasicMaterial( { color: 0x04A777 } );


const spher1 = new THREE.Mesh( geometry, material1 );
const spher2 = new THREE.Mesh( geometry, material2 );
const spher3 = new THREE.Mesh( geometry, material3 );
const spher4 = new THREE.Mesh( geometry, material4 );

spher1.position.copy(new THREE.Vector3(0, Math.cos(theta*Math.PI/180)*l1, Math.sin(theta*Math.PI/180)*l1));
spher2.position.copy(new THREE.Vector3(0, -l1, 0));
spher3.position.copy(new THREE.Vector3(l1, 0, 0));
spher4.position.copy(new THREE.Vector3(-l1, 0, 0));

return [spher1,spher2,spher3,spher4]
}


export {createMases}