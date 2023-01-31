import {BufferGeometry, Float32BufferAttribute, PointsMaterial, Points} from "../../../../../three.js-master/build/three.module.js";

function createPoints(){
    const escala = 1500;
    var dotGeometry = new BufferGeometry();
dotGeometry.setAttribute( 'position', new Float32BufferAttribute( [0*escala,0.05*escala,0*escala], 3 ) );
var dotMaterial = new PointsMaterial( { size: 10, color: 0xff0000,transparent:false,opacity: 1.0 } );
var dots = new Points( dotGeometry, dotMaterial );


    return dots
}

export { createPoints };
