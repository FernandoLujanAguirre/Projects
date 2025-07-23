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
import { buscarDatos } from "./buscar_datos_prisma_PrimerOrden.js";
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
let currentGimbal = null;
let currentRotor = null;
camera = createCamera(.3, .3, .3);
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

//Satelite
const satelite = createCube(.10, .10, .3, 1);

//---Prisma
const Cube = createCube(7, 4, 1, 1);

//GLTF
// Obtener el selector del menú
const dataSelector = document.getElementById('data-selector');

// Recuperar el valor seleccionado previamente (si existe) del almacenamiento local
const savedValue = localStorage.getItem('selectedData');
if (savedValue) {
    dataSelector.value = savedValue; // Establecer el valor guardado como seleccionado
}

// Cargar los modelos iniciales según el valor predeterminado o guardado
const initialValue = dataSelector.value;
loadModelsBasedOnSelection(initialValue);

// Función para manejar el cambio de datos en el menú
dataSelector.addEventListener('change', (event) => {
    const selectedValue = event.target.value;

    // Guardar el valor seleccionado en el almacenamiento local
    localStorage.setItem('selectedData', selectedValue);

    // Recargar la página
    location.reload();
});

// Función para cargar modelos según la selección
function loadModelsBasedOnSelection(selectedValue) {
    let rotorPath, gimbalPath;
    switch (selectedValue) {
        case './simulaciones/datos_GCMRA_PRIMSA_Linealizacion_Colocada.json':
            rotorPath = './Modelos_GLTF/prisma.gltf';
            gimbalPath = './Modelos_GLTF/Marco1.gltf';
            break;
        case './simulaciones/datos_GCMRA_PRIMSA_Linealizacion_No_Colocada.json':
            rotorPath = './Modelos_GLTF/prisma.gltf';
            gimbalPath = './Modelos_GLTF/Marco1.gltf';
            break;
        case './simulaciones/datos_GCMRA_PRIMSA_Linealizacion_No_Colocada_Simetria.json':
            rotorPath = './Modelos_GLTF/rotor.gltf';
            gimbalPath = './Modelos_GLTF/marco_sim.gltf';
            break;
        default:
            console.error('Modelos no definidos para esta opción.');
            return;
    }
// Variables globales para almacenar los modelos actuales

    Promise.all([loadModel(rotorPath), loadModel(gimbalPath)])
        .then(([loadedRotor, loadedGimbal]) => {
            if (currentRotor) {
                scene.remove(currentRotor);
            }
            if (currentGimbal) {
                scene.remove(currentGimbal);
            }

            currentRotor = loadedRotor;
            currentGimbal = loadedGimbal;

            currentGimbal.add(currentRotor);
            currentGimbal.position.set(0, 0, 0);
            currentRotor.position.set(0, 0, 0);

            scene.add(currentGimbal);
        })
        .catch((error) => {
            console.error('Error al cargar los modelos:', error);
        });
}

// Función para cargar un modelo GLTF/GLB
function loadModel(url) {
    return new Promise((resolve, reject) => {
        const loader = new GLTFLoader();
        loader.load(
            url,
            function (gltf) {
                const loadedModel = gltf.scene;
                resolve(loadedModel);
            },
            undefined,
            function (error) {
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
scene.add(Luces, habitacion, satelite, axesHelperMovil, axesHelperLast);

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
    const t2 = -buscarDatos(time.toFixed(2), "t2");
    const t3 = buscarDatos(time.toFixed(2), "t3");
    const t4 = -buscarDatos(time.toFixed(2), "t4");
    const t5 = buscarDatos(time.toFixed(2), "t5");
    const Mx = buscarDatos(time.toFixed(2), "Mx");
    const My = buscarDatos(time.toFixed(2), "My");
    const Mz = buscarDatos(time.toFixed(2), "Mz");

    const Sec1 = new Euler(t1, t2, t3, 'XYZ');
    axesHelperMovil.setRotationFromEuler(Sec1);
    satelite.setRotationFromEuler(Sec1);

    const Sec2 = new Euler(0, t4, 0, 'XYZ');
    const Sec3 = new Euler(t5, 0, 0, 'XYZ');

    satelite.setRotationFromEuler(Sec1);

    if (currentGimbal) {
        satelite.add(currentGimbal);
        currentGimbal.add(currentRotor);

        currentGimbal.setRotationFromEuler(Sec2);
    }
    if (currentRotor) {
        currentRotor.setRotationFromEuler(Sec3);
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
    const M = createTrail(new Vector3(0, 0, 0), new Vector3(Mx * 20, My * 20, Mz * 20));
    scene.children.splice(6, 1);
    v_old = v_new;
    if (scene.children.length > 3500) { scene.children.splice(5, 1); }
});
