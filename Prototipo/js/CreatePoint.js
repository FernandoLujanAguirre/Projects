import * as THREE from 'https://esm.sh/three@0.161.0';
function CreatePoint(s,x,y,z,color) {
// Crear geometría con un solo vértice
const geometry = new THREE.BufferGeometry();
const vertices = new Float32Array([x, y, z]); // posición del punto en (0,0,0)
geometry.setAttribute('position', new THREE.BufferAttribute(vertices, 3));

// Material para puntos
const material = new THREE.PointsMaterial({
  color: color, // rojo
  size: s,        // tamaño en píxeles
});

// Crear el objeto de puntos
const point = new THREE.Points(geometry, material);
return point;

}
export { CreatePoint };
