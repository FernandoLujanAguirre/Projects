import * as THREE from 'https://esm.sh/three@0.161.0';


  
  function createCube(w,h,d,s) {
  const cubeWcolor = new THREE.Group();
    // create a geometry
    const geometry = new THREE.BoxGeometry(w*s,h*s,d*s,4,4,4);

    // create a default (white) Basic material
    const MetalMaterial = new THREE.MeshStandardMaterial({ 
        color: 0X00ff92, 
        transparent: true, // Enable transparency
        opacity: 0.5,       // Set the opacity level (0.0 to 1.0)
        side: THREE.DoubleSide,
        wireframe:false,
        metalness: 1.0,   // between 0 and 1
        roughness: 0.5 // between 0 and 1
        
    });

  const materials = [
  new THREE.MeshStandardMaterial({ color: 0X0000ff,transparent:true,opacity: 0.5}), // cara 0: x
  new THREE.MeshStandardMaterial({ color: 0X0000ff,transparent:true,opacity: 0.5}), // cara 1: -x
  new THREE.MeshStandardMaterial({ color: 0X0000ff,transparent:true,opacity: 0.5}), // cara 2: y
  new THREE.MeshStandardMaterial({ color: 0X0000ff,transparent:true,opacity: 0.5}), // cara 3: -y
  new THREE.MeshStandardMaterial({ color: 0Xff0000,transparent:true,opacity: 0.5}), // cara 4: z
  new THREE.MeshStandardMaterial({ color: 0X00ff00,transparent:true,opacity: 0.5})  // cara 5: -z
];
  
    // create a Mesh containing the geometry and material
    const cube = new THREE.Mesh(geometry, materials);

    // edges from rectangle
    const edgeGeometry = new THREE.EdgesGeometry( geometry );
    const edges = new THREE.LineSegments( edgeGeometry, new THREE.LineBasicMaterial( { color: 0X00ff00 } ) );

    MetalMaterial.castShadow = true;

    cubeWcolor.add(cube, edges);
    return cubeWcolor
  }
  
  export { createCube };