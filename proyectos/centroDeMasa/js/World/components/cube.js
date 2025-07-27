import * as THREE from 'https://esm.sh/three@0.161.0';


function createCube() {
  const escala = 1500;
  // create a geometry
  const geometry = new THREE.BoxGeometry(.2*escala, .1*escala, .01*escala);

  // create a default (white) Basic material
  const material = new THREE.MeshBasicMaterial({color: 0x6BF0E7});

  // create a Mesh containing the geometry and material
  const cube = new THREE.Mesh(geometry, material);

  // edges from rectangle
  const edgeGeometry = new THREE.EdgesGeometry( geometry );
  const edges = new THREE.LineSegments( edgeGeometry, new THREE.LineBasicMaterial( { color: 0x000000 } ) );


  return [cube , edges];
}

export { createCube };