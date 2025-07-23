import { Clock, AxesHelper } from "../../../three.js-master/build/three.module.js";
import { createCamera } from './camera.js';
import { createScene } from './scene.js';
import { createLights } from './lights.js';
import { createAmbientLights } from "./CreateAmbientLight.js";
import { Resizer } from './Resizer.js';
import { createRenderer } from './renderer.js';
import { OrbitControls } from "../../../three.js-master/examples/jsm/controls/OrbitControls.js";
import { createSphere } from "./createSphere.js";
import { CreateTrail } from "./CreateTrail.js";
import { buscarDatos } from "./buscar_datos_ECP.js";
import { Group, Vector3, Line, LineBasicMaterial, BufferGeometry } from "../../three.js-master/build/three.module.js";
import { Euler } from "../../three.js-master/build/three.module.js";
import { CreatePlane } from "./CreatePlane.js";
import { createCube } from "./CreateCube.js";
import { GLTFLoader } from "../../three.js-master/examples/jsm/loaders/GLTFLoader.js";

const container = document.querySelector('#scene-container');

//-------

let camera;
let renderer;
let scene;
let currentModels = [];
camera = createCamera(.2, .2, .2);
renderer = createRenderer();
scene = createScene();

const controls = new OrbitControls(camera, renderer.domElement);
controls.update();

//Trail

//Luces-------
const light1 = createLights(2, 1, 0, 0);
const light2 = createLights(3, 0, 2, 0);
const light3 = createLights(3, 0, 0, 2);
const light4 = createLights(3, 2, 2, 2);
const light5 = createLights(3, -1, -1, -1);

const ambientLight = createAmbientLights();

const Luces = new Group();
Luces.add(light1, light2, light3, light4, light5);
//------------

//Axis Helper
const axesHelperMovil = new AxesHelper(2);
const axesHelperLast = new AxesHelper(3);

const Lastt1 = buscarDatos("Last", "t1");
const Lastt2 = -buscarDatos("Last", "t2");
const Lastt3 = buscarDatos("Last", "t3");

const SecAxes = new Euler(0, 0, 0, 'XYZ');
axesHelperLast.setRotationFromEuler(SecAxes);
//-------------

// add the automatically created <canvas> element to the page
container.append(renderer.domElement);

//Floor

const w = 5;
const h = 5;
const plane = CreatePlane(w, h);
const paredR = plane.clone();
const paredL = paredR.clone();
const habitacion = new Group();

plane.position.z = -w / 2;
paredR.rotation.y = Math.PI / 2;
paredR.position.x = -w / 2;
paredL.position.y = -w / 2;
paredL.rotation.x = -Math.PI / 2;
habitacion.add(plane, paredR, paredL);
//----------------------



// Cargar múltiples modelos GLTF
const modelsToLoad = [
    { modelPath: './Modelos_GLTF/Gimbal1.gltf' },
    { modelPath: './Modelos_GLTF/Gimbal2.gltf' },
    { modelPath: './Modelos_GLTF/Gimbal3.gltf' },
    { modelPath: './Modelos_GLTF/Rueda.gltf' }
];

// Función para cargar múltiples modelos
function loadMultipleModels(models) {
    models.forEach((model, index) => {
        loadModel(model.modelPath)
            .then((loadedModel) => {
                // Configurar posiciones iniciales si es necesario
                

                // Agregar a la escena
                scene.add(loadedModel);

                // Almacenar en un array global
                currentModels.push(loadedModel);

                // Configurar posiciones específicas solo si todos los modelos están cargados
                if (currentModels.length === models.length) {
                    console.log('Todos los modelos cargados:', currentModels.length);

                    // Configurar posiciones para los modelos cargados
                    if (currentModels[1]) {
                        currentModels[1].position.set(0, 0, 0.05082074 + 0.002 / 2);
                    }
                    if (currentModels[2]) {
                        currentModels[2].position.set(0, 0, 0.05082074 + 0.004 / 2);
                    }
                    if (currentModels[3]) {
                        currentModels[2].add(currentModels[3]);
                        currentModels[3].position.set(0, 0, 0);
                    }
                }
            })
            .catch((error) => {
                console.error('Error al cargar el modelo:', error);
            });
    });
}


// Llamar a la función para cargar los modelos
loadMultipleModels(modelsToLoad);


function loadModel(url) {
    return new Promise((resolve, reject) => {
        const loader = new GLTFLoader();
        loader.load(
            url,
            function (gltf) {
                console.log(`Modelo cargado: ${url}`); // Mensaje de depuración
                const loadedModel = gltf.scene;
                resolve(loadedModel);
            },
            undefined,
            function (error) {
                console.error(`Error al cargar el modelo ${url}:`, error);
                reject(error);
            }
        );
    });
}


//Trail------
let v_oldd_x = 0;
let v_oldd_y = 0.05;
let v_oldd_z = 0;
let v_old = new Vector3(v_oldd_x, v_oldd_y, v_oldd_z);
//----------

//Agregar a la escena
scene.add(Luces, habitacion,axesHelperLast);

//Slider
let sliderValue = document.getElementById('mySlider').value;
document.getElementById('mySlider').addEventListener('input', function () {
    sliderValue = this.value;
    document.getElementById('sliderValue').textContent = "x" + sliderValue;
});

//--------------

const resizer = new Resizer(container, camera, renderer);
resizer.onResize = () => {
    renderer.render(scene, camera);
};

const clock = new Clock();

let time = 0;




renderer.setAnimationLoop(() => {
    renderer.render(scene, camera);
    const delta = clock.getDelta();
    time += delta * sliderValue;

    const t1 = buscarDatos(time.toFixed(2), "t1");
    const t2 = buscarDatos(time.toFixed(2), "t2");
    const t3 = -buscarDatos(time.toFixed(2), "t3");
    const t4 = buscarDatos(time.toFixed(2), "t4");
    

    const Sec1 = new Euler(0,0,t1, 'ZXY');
    const Sec2 = new Euler(t2,0,t1, 'ZXY');
    const Sec3 = new Euler(t2,t3,t1, 'ZXY');
    const Sec4 = new Euler(t4,0,0, 'ZXY');


    if (currentModels[0]) {
        currentModels[0].setRotationFromEuler(Sec1);
        
    }

    if (currentModels[1]) {
        currentModels[1].setRotationFromEuler(Sec2);
        ;
    }
    
    if (currentModels[2]) {
        currentModels[2].setRotationFromEuler(Sec3);
        ;
    }

    if (currentModels[3]) {
        currentModels[3].setRotationFromEuler(Sec4)
        ;
    }

    let v_new = new Vector3(v_oldd_x, v_oldd_y, v_oldd_z).applyEuler(Sec1);

    function createTrail(v_old, v_new) {
        const material = new LineBasicMaterial({
            color: 0xffffff
        });
        let vertices = [];
        vertices.push(v_old);
        vertices.push(v_new);

        const geometry = new BufferGeometry().setFromPoints(vertices);

        const line = new Line(geometry, material);

        return (line);
    }
    //scene.children.splice(6, 1);
    v_old = v_new;
    if (scene.children.length > 3500) { scene.children.splice(5, 1); }
});
