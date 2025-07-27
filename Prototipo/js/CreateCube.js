import * as THREE from 'https://esm.sh/three@0.161.0';


  
  function createCube(w,h,d,s) {
  
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
  
    // create a Mesh containing the geometry and material
    const cube = new THREE.Mesh(geometry, MetalMaterial);

    // edges from rectangle
    const edgeGeometry = new THREE.EdgesGeometry( geometry );
    const edges = new THREE.LineSegments( edgeGeometry, new THREE.LineBasicMaterial( { color: 0x000000 } ) );

    MetalMaterial.castShadow = true;
    return cube
  }
  
  export { createCube };