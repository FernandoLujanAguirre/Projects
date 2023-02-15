import {Vector3, ArrowHelper} from "../../../../../three.js-master/build/three.module.js"


function VectorcentroMasa(){
const theta = 45;
const dir= new Vector3 (0,(10*Math.cos(theta)-10)/4,(5*Math.sin(theta/9))/2);
dir.normalize();
const origin = new Vector3( 0, 0, 0 );
const length = Math.sqrt(dir.x**2+dir.y**2+dir.z**2);
const color = 0xffff00;
const arrowHelper = new ArrowHelper( dir, origin, length, color );
return arrowHelper
}

export {VectorcentroMasa}