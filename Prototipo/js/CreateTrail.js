import { LineBasicMaterial, BufferGeometry, Line, Vector3 ,BufferAttribute} from "../../../../../three.js-master/build/three.module.js";


function CreateTrail(Ox,Oy,Oz,x,y,z){
    const material = new LineBasicMaterial({
        color: 0x0000ff
    });
    
    const vertices = [];
    vertices.push( new Vector3( Ox,Oy,Oz ) );
    vertices.push( new Vector3(x,y,z ) );
    const geometry = new BufferGeometry().setFromPoints( vertices );
    
    const line = new Line( geometry, material );
    return(line);
    }
    
    export {CreateTrail}