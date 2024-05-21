import { LineBasicMaterial, BufferGeometry, Vector3, Line } from "../../../../../three.js-master/build/three.module.js";


function createLine(x,y,z){

const material = new LineBasicMaterial({
	color: 0x222222
});

const points = [];
points.push( new Vector3( -0.03,-0.03, 0 ) );

points.push( new Vector3( 0, 0, 0 ) );
points.push( new Vector3( 0,0.06, 0 ) );


const geometry = new BufferGeometry().setFromPoints( points );

const line = new Line( geometry, material );
return line

}

export{createLine}