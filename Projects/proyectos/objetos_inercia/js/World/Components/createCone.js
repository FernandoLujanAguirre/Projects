import { ConeGeometry,MeshPhongMaterial, Mesh } from "../../../../../three.js-master/build/three.module.js";


function createCone(radius,height, radialSegments){
    const geometry = new ConeGeometry( radius,height, radialSegments );
    const material = new MeshPhongMaterial( {color: 0xffff00} );
    const cone = new Mesh( geometry, material );

    return cone
}

export{createCone}