import * as THREE from 'https://esm.sh/three@0.161.0';

function CreatePlane(w,h){
    const planeGeometry = new THREE.PlaneGeometry(w, h,10,10);
    const planeMaterial = new THREE.MeshStandardMaterial({ 
        color: 0X4b55f5, 
        transparent: true, // Enable transparency
        opacity: 0.9,       // Set the opacity level (0.0 to 1.0)
        side: THREE.DoubleSide,
        wireframe:false,
        metalness: 1.0,   // between 0 and 1
        roughness: 0.5, // between 0 and 1
        
    });

const wirePlane = new THREE.MeshPhongMaterial({ 
    color: 0x000000, 
    transparent: false, // Enable transparency
    opacity: 1,       // Set the opacity level (0.0 to 1.0)
    side: THREE.DoubleSide,
    wireframe:true
});
    

    const plane = new THREE.Mesh(planeGeometry, planeMaterial);
    const wires = new THREE.Mesh(planeGeometry,wirePlane)
    plane.receiveShadow = false;

    const plano = new THREE.Group();
    plano.add(plane,wires)
    

    return plane
}

export {CreatePlane}