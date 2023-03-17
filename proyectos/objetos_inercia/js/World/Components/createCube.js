import { Color, 
  BoxGeometry, 
  Mesh, 
  MeshStandardMaterial,
  MeshBasicMaterial,
  EdgesGeometry,
  LineSegments,
  LineBasicMaterial,
MeshPhongMaterial} 
  
  from "../../../../../three.js-master/build/three.module.js";

function createCube(w,h,d,s) {

  // create a geometry
  const geometry = new BoxGeometry(w*s,h*s,d*s);

  // create a default (white) Basic material
  const material = new MeshPhongMaterial({color: 0xffffff});

  // create a Mesh containing the geometry and material
  const cube = new Mesh(geometry, material);

  // edges from rectangle
  const edgeGeometry = new EdgesGeometry( geometry );
  const edges = new LineSegments( edgeGeometry, new LineBasicMaterial( { color: 0x000000 } ) );
    
  material.castShadow = true;
  return [cube , edges];
}

export { createCube };