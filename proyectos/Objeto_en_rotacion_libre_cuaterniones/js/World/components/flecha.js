import {Vector3, ArrowHelper} from "../../../../../three.js-master/build/three.module.js"

function flecha(Vx,Vy,Vz,Ox,Oy,Oz,Color){ 
    // Vx Vy Vz are the componentes of a vector
    // Ox Oy Oz are the coordinates of origin
    
    const Vector = new Vector3(Vx,Vy,Vz);    
    const Origen = new Vector3(Ox,Oy,Oz);    
    
    const lengthVec = Math.sqrt(Vector.x**2+Vector.y**2+Vector.z**2);// Calculates the length of vector V
    
    const VectorUnit = new Vector3 (Vector.x/lengthVec,Vector.y/lengthVec,Vector.z/lengthVec); // Normalize the vector
    
    const Flecha = new ArrowHelper( VectorUnit, Origen, lengthVec, Color ); //Build the arrow
    
    //Flecha.Vector=Vector; // add the original vector values to a  property in flecha
    
    return Flecha
    }
    
    export {flecha}