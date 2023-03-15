import {SphereGeometry, MeshBasicMaterial, Mesh, Vector3, Sphere} from "../../../../../three.js-master/build/three.module.js"

function createMases(){
    let theta = 0;
const l1 = 1;
const geometry = new SphereGeometry( 0.1, 64, 32 );
const material1 = new MeshBasicMaterial( { color: 0xFB8B24 } );
const material2 = new MeshBasicMaterial( { color: 0xD90368 } );
const material3 = new MeshBasicMaterial( { color: 0x084887 } );
const material4 = new MeshBasicMaterial( { color: 0x04A777 } );


const spher1 = new Mesh( geometry, material1 );
const spher2 = new Mesh( geometry, material2 );
const spher3 = new Mesh( geometry, material3 );
const spher4 = new Mesh( geometry, material4 );

spher1.position.copy(new Vector3(0, Math.cos(theta*Math.PI/180)*l1, Math.sin(theta*Math.PI/180)*l1));
spher2.position.copy(new Vector3(0, -l1, 0));
spher3.position.copy(new Vector3(l1, 0, 0));
spher4.position.copy(new Vector3(-l1, 0, 0));

return [spher1,spher2,spher3,spher4]
}


export {createMases}