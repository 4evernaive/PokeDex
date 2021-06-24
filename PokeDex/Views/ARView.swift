//
//  ARView.swift
//  PokeDex
//
//  Created by Vesper Lee on 2021/5/28.
//

import Foundation
import ARKit
import SceneKit
import SwiftUI


var objName :String = ""
func getThreed(name:String){
    switch name.capitalized {
    case "Charizard":
        objName="charizard-pokemon-go.obj"
    case "Zapdos":
        objName="zapados-pokemon-go.obj"
    case "Scyther":
        objName="scyther-pokemon-go.obj"
    case "Gyarados":
        objName="gyrados-pokemon-go.obj"
    case "Dragonite":
        objName="dragonite-pokemon-go.obj"
    case "Bulbasaur":
        objName="bulbasaur-pokemon-go.obj"
    case "Articuno":
        objName="articuno-pokemon-go.obj"
    default:
        objName="pokeball.obj"
    }

}

struct ARViewIndicator: UIViewControllerRepresentable {
   
    typealias UIViewControllerType = ARView
    
    func makeUIViewController(context: Context) -> ARView {
        return ARView()
    }
    func updateUIViewController(_ uiViewController:
                                    ARViewIndicator.UIViewControllerType, context:
                                        UIViewControllerRepresentableContext<ARViewIndicator>) { }
}

extension float4x4 {
    var translation: SIMD3<Float> {
        let translation = self.columns.3
        return SIMD3<Float>(translation.x, translation.y, translation.z)
    }
}
class ARView: UIViewController, ARSCNViewDelegate {
    
    var arView: ARSCNView {
        return self.view as! ARSCNView
    }
    override func loadView() {
        self.view = ARSCNView(frame: .zero)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        arView.delegate = self
        //let model_3d = SCNScene(named: "charizard-pokemon-go.obj")!
        //let node = model_3d.rootNode.childNode(withName: "cup", recursively: true)!
        configureLighting()
        //addPaperPlane()
        //addCar()
        addTapGestureToSceneView()
        //arView.scene = model_3d
    }
    
    func addTapGestureToSceneView() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.addPokemonToSceneView(withGestureRecognizer:)))
        arView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func configureLighting() {
        arView.autoenablesDefaultLighting = true
        arView.automaticallyUpdatesLighting = true
    }
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        // 1
        guard let planeAnchor = anchor as? ARPlaneAnchor else { return }
        
        // 2
        let width = CGFloat(planeAnchor.extent.x)
        let height = CGFloat(planeAnchor.extent.z)
        let plane = SCNPlane(width: width, height: height)
        
        // 3
        plane.materials.first?.diffuse.contents = UIColor.clear
        
        // 4
        let planeNode = SCNNode(geometry: plane)
        
        // 5
        let x = CGFloat(planeAnchor.center.x)
        let y = CGFloat(planeAnchor.center.y)
        let z = CGFloat(planeAnchor.center.z)
        planeNode.position = SCNVector3(x,y,z)
        planeNode.eulerAngles.x = -.pi / 2
        
        // 6
        node.addChildNode(planeNode)
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        guard let planeAnchor = anchor as?  ARPlaneAnchor,
              let planeNode = node.childNodes.first,
              let plane = planeNode.geometry as? SCNPlane
        else { return }
        
        // 2
        let width = CGFloat(planeAnchor.extent.x)
        let height = CGFloat(planeAnchor.extent.z)
        plane.width = width
        plane.height = height
        
        // 3
        let x = CGFloat(planeAnchor.center.x)
        let y = CGFloat(planeAnchor.center.y)
        let z = CGFloat(planeAnchor.center.z)
        planeNode.position = SCNVector3(x, y, z)
    }
    
    @objc func addPokemonToSceneView(withGestureRecognizer recognizer: UIGestureRecognizer) {
        let tapLocation = recognizer.location(in: arView)
        guard let query = arView.raycastQuery(from: tapLocation, allowing: .existingPlaneInfinite, alignment: .any) else {
            return
        }
        
        let results = arView.session.raycast(query)
        guard let hitTestResult = results.first else { return }
        let translation = hitTestResult.worldTransform.translation
        let x = translation.x
        let y = translation.y
        let z = translation.z
        
        guard let pmScene = SCNScene(named: objName)else { return }
        let pmNode = SCNNode()
        let pmNodeChildNodes = pmScene.rootNode.childNodes
        
        for childNode in pmNodeChildNodes {
            pmNode.addChildNode(childNode)
        }
        
        pmNode.position = SCNVector3(x,y,z)
        pmNode.scale = SCNVector3(0.01, 0.01, 0.01)
        arView.scene.rootNode.addChildNode(pmNode)
    }
    
    // MARK: - Functions for standard AR view handling
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        arView.session.run(configuration)
        arView.delegate = self
        arView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        arView.session.pause()
    }
    
    // MARK: - ARSCNViewDelegate
    func sessionWasInterrupted(_ session: ARSession) {}
    
    func sessionInterruptionEnded(_ session: ARSession) {}
    func session(_ session: ARSession, didFailWithError error: Error)
    {}
    func session(_ session: ARSession, cameraDidChangeTrackingState
                    camera: ARCamera) {}
}
