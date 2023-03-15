import { CylinderGeometry,MeshBasicMaterial, Mesh, Vector3} from "../../../../../three.js-master/build/three.module.js";

function cilindros(){

const geometry = new CylinderGeometry( 0.01, 0.01, 1, 32 );
const geometry2 = new CylinderGeometry( 0.01, 0.01, 2, 32 );


const material = new MeshBasicMaterial( {color: 0xffff00} );
const cylinder1 = new Mesh( geometry, material );
const cylinder2 = new Mesh( geometry2, material );
const cylinder3 = new Mesh( geometry, material );


cylinder1.position.copy(new Vector3(0,-0.5,0));
cylinder2.rotateZ(Math.PI/2);

cylinder3.position.copy(new Vector3(0,0.5*Math.cos(0),0.5*Math.sin(0/4)));
cylinder3.rotateX(0);

return [cylinder1,cylinder2,cylinder3]

}

export{cilindros}