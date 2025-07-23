import { Color, 
    BoxGeometry, 
    Mesh, 
    MeshStandardMaterial,
    MeshBasicMaterial,
    EdgesGeometry,
    LineSegments,
    LineBasicMaterial,
  MeshPhongMaterial,
DoubleSide} 
    
    from "../../three.js-master/build/three.module.js";
  
  function createCube(w,h,d,s) {
  
    // create a geometry
    const geometry = new BoxGeometry(w*s,h*s,d*s,4,4,4);
  
    // create a default (white) Basic material
    const MetalMaterial = new MeshStandardMaterial({ 
        color: 0X00ff92, 
        transparent: true, // Enable transparency
        opacity: 0.5,       // Set the opacity level (0.0 to 1.0)
        side: DoubleSide,
        wireframe:false,
        metalness: 1.0,   // between 0 and 1
        roughness: 0.5 // between 0 and 1
        
    });
  
    // create a Mesh containing the geometry and material
    const cube = new Mesh(geometry, MetalMaterial);
  
    // edges from rectangle
    const edgeGeometry = new EdgesGeometry( geometry );
    const edges = new LineSegments( edgeGeometry, new LineBasicMaterial( { color: 0x000000 } ) );
      
    MetalMaterial.castShadow = true;
    return cube
  }
  
  export { createCube };