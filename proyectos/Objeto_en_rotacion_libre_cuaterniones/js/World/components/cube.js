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

function createCube() {
  const escala = 1;
  // create a geometry
  const geometry = new BoxGeometry(.2*escala, .1*escala, .01*escala);

  // create a default (white) Basic material
  const material = new MeshPhongMaterial({color: 0xff3333});

  // create a Mesh containing the geometry and material
  const cube = new Mesh(geometry, material);

  // edges from rectangle
  const edgeGeometry = new EdgesGeometry( geometry );
  const edges = new LineSegments( edgeGeometry, new LineBasicMaterial( { color: 0x000000 } ) );
    

  return [cube , edges];
}

export { createCube };