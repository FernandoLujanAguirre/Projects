// LowerModel.js - Versión optimizada
// Jerarquía: satPivot -> satelite -> currentGimbal -> currentRotor
// Rotación aplicada solo a pivotes para evitar recálculos costosos en nodos GLTF

import { buscarDatos } from "../DataSearch/FiveDoF.js";
import { createRenderer } from '../renderer.js';
import { createCamera } from '../camera.js';
import { createScene } from '../scene.js';
import { createLights } from '../lights.js';
import { createAmbientLights } from "../CreateAmbientLight.js";
import { Resizer } from '../Resizer.js';
import { createSphere } from "../createSphere.js";
import { CreateTrail } from "../CreateTrail.js";
import { CreatePlane } from "../CreatePlane.js";
import { createCube } from "../CreateCube.js";
import { CreatePoint } from "../CreatePoint.js";
import { OrbitControls } from 'https://esm.sh/three@0.161.0/examples/jsm/controls/OrbitControls.js';
import { GLTFLoader } from 'https://esm.sh/three@0.161.0/examples/jsm/loaders/GLTFLoader.js';
import { CreateLabel } from '../CreateLabel.js';
import { Labels } from '../DataSearch/Labels.js';
import * as THREE from 'https://esm.sh/three@0.161.0';
import { labelRenderer } from "../LabelRenderer.js";
import { CreateLine } from "../CreateLine.js";

// -----------------------------------------------------------------------------
// CONFIG / ELEMENTOS PRINCIPALES
// -----------------------------------------------------------------------------
const container = document.querySelector('#animation-container');
if (!container) throw new Error("No se encontró #animation-container en el DOM");

// Limpieza segura del contenedor (evita canvases duplicados)
while (container.firstChild) container.removeChild(container.firstChild);

// Crear escena/cámara/renderer una vez
const camera = createCamera(0.5, 0.5, 0.5);
const renderer = createRenderer();
const scene = createScene();

// limitar pixel ratio para rendimiento (ajusta si necesitas más calidad)
renderer.setPixelRatio(1);
renderer.domElement.style.display = 'block';
renderer.domElement.style.width = '100%';
renderer.domElement.style.height = '100%';
container.appendChild(renderer.domElement);

const controls = new OrbitControls(camera, renderer.domElement);
controls.enableDamping = true;
controls.dampingFactor = 0.08;

// Luces y helpers
const light1 = createLights(2, 1, 0, 0);
const light2 = createLights(3, 0, 2, 0);
const light3 = createLights(3, 0, 0, 2);
const light4 = createLights(3, 2, 2, 2);
const light5 = createLights(3, -1, -1, -1);
const ambientLight = createAmbientLights();
const Luces = new THREE.Group();
Luces.add(light1, light2, light3, light4, light5);

const axesHelperMovil = new THREE.AxesHelper(0.2);
const axesHelperLast = new THREE.AxesHelper(10);

// Habitacion / plano
const w = 1.0;
const plane = CreatePlane(w, w, 0x2300FF);
const paredR = plane.clone();
const paredL = paredR.clone();
const habitacion = new THREE.Group();
plane.position.z = -w / 2;
paredR.rotation.y = Math.PI / 2;
paredR.position.x = -w / 2;
paredL.position.y = -w / 2;
paredL.rotation.x = -Math.PI / 2;
habitacion.add(plane, paredR, paredL);

// Satellite (representación simple) - se cuelga del pivot
const satelite = createCube(.10, .10, .3, 1);

// Punto inicial y esfera (estáticos)
const InitialRot = new THREE.Euler(buscarDatos(0, "t1"), -buscarDatos(0, "t2"), buscarDatos(0, "t3"), 'XYZ');
const InitialPos = new THREE.Vector3(0, 0, 0.15).applyEuler(InitialRot);
const point0 = CreatePoint(0.02, InitialPos.x, InitialPos.y, InitialPos.z, 'red');
const sphere = createSphere(0.2, 0, 0, 0);

// -----------------------------------------------------------------------------
// PIVOTES: creados antes de cargar modelos y antes del loop
// -----------------------------------------------------------------------------
// Opción A (jerarquía): satPivot -> satelite -> currentGimbal -> currentRotor
const satPivot = new THREE.Object3D();
const gimbalPivot = new THREE.Object3D();
const rotorPivot = new THREE.Object3D();

// montar pivotes en escena
scene.add(satPivot);
scene.add(gimbalPivot);
scene.add(rotorPivot);

// cuelga el cube del satPivot para que se vea la referencia del satélite
satPivot.add(satelite);

// -----------------------------------------------------------------------------
// Labels y puntos (optimizado)
// -----------------------------------------------------------------------------
function grad2rad(grad) { return grad * (Math.PI / 180); }
function radToDeg(radians) { return radians * (180 / Math.PI); }

const labelGroup = new THREE.Group();
const points = new THREE.Group();
const labelsData = await Labels(); // asumes que Labels() devuelve promesa
const offset = grad2rad(5);
const qd = new THREE.Euler(labelsData["q1d"], -labelsData["q2d"], 0, 'XYZ');
const qd_offset = new THREE.Euler(labelsData["q1d"] + offset, -labelsData["q2d"] + offset, offset, 'XYZ');

const labelPositions = [
  InitialPos.clone(),
  new THREE.Vector3(0, 0.1, 0.2).applyEuler(qd_offset),
  new THREE.Vector3(0, 0.0, 0.2).applyEuler(new THREE.Euler(grad2rad(-135), grad2rad(-45), 0, 'XYZ')),
];

const label0 = CreateLabel('x:' + radToDeg(buscarDatos(0, "t1")).toFixed(2) + ' y:' + radToDeg(buscarDatos(0, "t2")).toFixed(2), 'black', '16px');
const label1 = CreateLabel('x:' + radToDeg(labelsData["q1d"]).toFixed(2) + ' y:' + radToDeg(labelsData["q2d"]).toFixed(2), 'black', '16px');
const label2 = CreateLabel('x:-135' + ' y:45', 'black', '16px');

const point = CreatePoint(0.005, 0, 0, 0.15, 'blue');
const point1Coordinate = new THREE.Vector3(0, 0, 0.15).applyEuler(new THREE.Euler(labelsData["q1d"], -labelsData["q2d"], 0, 'XYZ'));
const point1 = CreatePoint(0.02, point1Coordinate.x, point1Coordinate.y, point1Coordinate.z, 'green');
const point2Coordinate = new THREE.Vector3(0, 0, 0.15).applyEuler(new THREE.Euler(grad2rad(-135), -grad2rad(45), 0, 'XYZ'));
const point2 = CreatePoint(0.02, point2Coordinate.x, point2Coordinate.y, point2Coordinate.z, 'green');

const Lines = new THREE.Group();
const LabelLine = CreateLine(point1Coordinate, new THREE.Vector3(0, 0.1, 0.2).applyEuler(qd_offset));
const Label2Line = CreateLine(point2Coordinate, new THREE.Vector3(0, 0.0, 0.2).applyEuler(new THREE.Euler(grad2rad(-135), grad2rad(-45), 0, 'XYZ')));
Lines.add(LabelLine, Label2Line);

points.add(point0, point1);
labelGroup.add(label0, label1);

// almacenar referencias DOM de labels (CreateLabel debe exponer .element)
const labelChildren = Array.from(labelGroup.children);
const labelDOMs = labelChildren.map(c => c.element).filter(Boolean);
labelDOMs.forEach(el => {
  el.style.position = 'absolute';
  el.style.transform = 'translate(-50%, -50%)';
  container.appendChild(el);
});

// -----------------------------------------------------------------------------
// Model loader y montaje (usar la jerarquía A)
// -----------------------------------------------------------------------------
let currentGimbal = null;
let currentRotor = null;

const loader = new GLTFLoader();

function loadModel(url) {
  return new Promise((resolve, reject) => {
    loader.load(url, (gltf) => resolve(gltf.scene), undefined, reject);
  });
}

// Rutas iniciales (ajusta según necesidad)
let rotorPath = './Modelos_GLTF/rotor.gltf';
let gimbalPath = './Modelos_GLTF/Marco1.gltf';

async function loadModelsBasedOnSelection(selectedValue) {
  switch (selectedValue) {
    case './simulaciones/Data/Satellite_With_Gyroscope_Two_Axis_Control.json':
      rotorPath = './Modelos_GLTF/rotor.gltf';
      gimbalPath = './Modelos_GLTF/marco_sim.gltf';
      break;
    default:
      console.warn('Opción por defecto, rutas asignadas');
  }

  try {
    const [loadedRotor, loadedGimbal] = await Promise.all([loadModel(rotorPath), loadModel(gimbalPath)]);

    // limpiar previos si existen
    if (currentRotor && currentRotor.parent) currentRotor.parent.remove(currentRotor);
    if (currentGimbal && currentGimbal.parent) currentGimbal.parent.remove(currentGimbal);

    // asignar
    currentGimbal = loadedGimbal;
    currentRotor = loadedRotor;

    // JERARQUÍA A: satelite -> currentGimbal -> currentRotor
    // ya tenemos satelite colgado en satPivot, así que colgamos gimbal en satelite
    satelite.add(currentGimbal);
    currentGimbal.add(currentRotor);

    // Asegurar posiciones relativas a 0
    currentGimbal.position.set(0, 0, 0);
    currentRotor.position.set(0, 0, 0);

    // Desactivar sombras intensas en todo el GLTF (opcional pero recomendado)
    currentGimbal.traverse(o => {
      if (o.isMesh) {
        o.castShadow = false;
        o.receiveShadow = false;
        // Opcional: reemplazar materiales muy pesados por Phong si hace falta
        // if (o.material && o.material.isMeshStandardMaterial) {
        //   o.material = new THREE.MeshPhongMaterial({ color: o.material.color });
        // }
      }
    });

  } catch (err) {
    console.error('Error cargando modelos:', err);
  }
}

// Selección de datos (preserva tu comportamiento anterior)
const dataSelector = document.getElementById('data-selector');
const savedValue = localStorage.getItem('selectedData');
if (savedValue) dataSelector.value = savedValue;
const initialValue = dataSelector.value;
loadModelsBasedOnSelection(initialValue);

dataSelector.addEventListener('change', (event) => {
  const selectedValue = event.target.value;
  localStorage.setItem('selectedData', selectedValue);
  // recarga para simplificar: mantiene comportamiento previo
  location.reload();
});

// -----------------------------------------------------------------------------
// Escena estática agregada una sola vez
// -----------------------------------------------------------------------------
scene.add(Luces, ambientLight, habitacion, points, axesHelperLast, satPivot);

// -----------------------------------------------------------------------------
// Slider y Resizer
// -----------------------------------------------------------------------------
let sliderValue = parseFloat(document.getElementById('mySlider').value || 1);
document.getElementById('mySlider').addEventListener('input', function () {
  sliderValue = parseFloat(this.value);
  document.getElementById('sliderValue').textContent = "x" + this.value;
});

const resizer = new Resizer(container, camera, renderer);
resizer.onResize = () => {
  renderer.render(scene, camera);
};

// -----------------------------------------------------------------------------
// Safe buscarDatos + cache ligera
// -----------------------------------------------------------------------------
let lastAngles = {
  t1: buscarDatos(0, "t1"),
  t2: buscarDatos(0, "t2"),
  t3: buscarDatos(0, "t3"),
  t4: buscarDatos(0, "t4"),
  t5: buscarDatos(0, "t5")
};

const buscarCache = new Map();
function cacheKey(tRounded, name) { return tRounded + '|' + name; }
function safeBuscar(tRounded, name) {
  const key = cacheKey(tRounded, name);
  if (buscarCache.has(key)) return buscarCache.get(key);
  const val = buscarDatos(tRounded, name);
  if (typeof val !== 'number' || !isFinite(val)) return lastAngles[name];
  lastAngles[name] = val;
  buscarCache.set(key, val);
  if (buscarCache.size > 2000) {
    const it = buscarCache.keys();
    buscarCache.delete(it.next().value);
  }
  return val;
}

// -----------------------------------------------------------------------------
// Loop de animación: minimal allocations, rotar solo pivotes
// -----------------------------------------------------------------------------
const clock = new THREE.Clock();
let accTime = 0;
let frame = 0;
const LABEL_UPDATE_RATE = 4;

// vectores temporales reutilizables
const tmpVec = new THREE.Vector3();

function animate() {
  requestAnimationFrame(animate);

  controls.update();

  const delta = clock.getDelta();
  accTime += delta * sliderValue;

  const tRoundedNum = Math.round(accTime * 100) / 100;
  const tKey = tRoundedNum.toString();

  const t1 = safeBuscar(tKey, "t1");
  const t2 = safeBuscar(tKey, "t2");
  const t3 = safeBuscar(tKey, "t3");
  const t4 = safeBuscar(tKey, "t4");
  const t5 = safeBuscar(tKey, "t5");

  // Aplicar rotaciones SOLO a pivotes 
  satPivot.rotation.x = t1;
  satPivot.rotation.y = -t2;
  satPivot.rotation.z = t3;

  // gimbal/rotor están colgados en la jerarquía A
  if (currentGimbal) {
    // podemos rotar el objeto gimbal directamente, pero es más barato rotar su pivot
    // en la jerarquía A el gimbal es hijo del satelite, así que rotarlo directamente está bien
    currentGimbal.rotation.set(0, -t4, 0);
  }
  if (currentRotor) {
    currentRotor.rotation.x = t5;
  }

  // Labels: actualizar cada N frames
  frame++;
  if ((frame % LABEL_UPDATE_RATE) === 0) {
    for (let i = 0; i < labelPositions.length; i++) {
      const el = labelDOMs[i];
      if (!el) continue;
      tmpVec.copy(labelPositions[i]);
      tmpVec.project(camera);
      const x = (tmpVec.x * 0.5 + 0.5) * container.clientWidth;
      const y = (tmpVec.y * -0.5 + 0.5) * container.clientHeight;
      el.style.transform = `translate(-50%, -50%) translate(${Math.round(x)}px, ${Math.round(y)}px)`;
    }
  }

  renderer.render(scene, camera);
}

// arrancar
requestAnimationFrame(animate);

// -----------------------------------------------------------------------------
// Fin archivo
// -----------------------------------------------------------------------------
