import { ConeGeometry,MeshPhongMaterial, Mesh } from 'https://esm.sh/three@0.161.0';


function createCone(radius,height, radialSegments){
    const geometry = new ConeGeometry( radius,height, radialSegments );
    const material = new MeshPhongMaterial( {color: 0xffff00} );
    const cone = new Mesh( geometry, material );

    return cone
}

export{createCone}