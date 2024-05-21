import {MeshLambertMaterial,MeshStandardMaterial,PlaneGeometry, ShadowMaterial,Mesh, MeshBasicMaterial,MeshPhongMaterial, DoubleSide, Group } from "../../three.js-master/build/three.module.js";

function CreatePlane(w,h){
    const planeGeometry = new PlaneGeometry(w, h,10,10);
    const planeMaterial = new MeshStandardMaterial({ 
        color: 0X4b55f5, 
        transparent: true, // Enable transparency
        opacity: 0.9,       // Set the opacity level (0.0 to 1.0)
        side: DoubleSide,
        wireframe:false,
        metalness: 1.0,   // between 0 and 1
        roughness: 0.5, // between 0 and 1
        
    });

const wirePlane = new MeshPhongMaterial({ 
    color: 0x000000, 
    transparent: false, // Enable transparency
    opacity: 1,       // Set the opacity level (0.0 to 1.0)
    side: DoubleSide,
    wireframe:true
});
    

    const plane = new Mesh(planeGeometry, planeMaterial);
    const wires = new Mesh(planeGeometry,wirePlane)
    plane.receiveShadow = false;

    const plano = new Group();
    plano.add(plane,wires)
    

    return plane
}

export {CreatePlane}