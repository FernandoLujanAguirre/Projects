import {SphereGeometry, MeshBasicMaterial, Mesh, Vector3, Sphere} from "../../../../../three.js-master/build/three.module.js"

function createMases(){
const theta = 45;
const geometry = new SphereGeometry( 1, 64, 32 );
const material = new MeshBasicMaterial( { color: 0xffffff } );
const spher1 = new Mesh( geometry, material );
const spher2 = new Mesh( geometry, material );
const spher3 = new Mesh( geometry, material );
const spher4 = new Mesh( geometry, material );

spher1.position.copy(new Vector3(10, 0, 0));
spher2.position.copy(new Vector3(-10, 0, 0));
spher3.position.copy(new Vector3(0, -10, 0));
spher4.position.copy(new Vector3(0, Math.cos(theta*Math.PI/180)*10, Math.sin(theta*Math.PI/180)*10));

return [spher1,spher2,spher3,spher4]
}


export {createMases}