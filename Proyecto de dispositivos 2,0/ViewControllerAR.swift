//
//  ViewController.swift
//  Prueba AR
//
//  Created by Carlos Balcazar on 27/03/18.
//  Copyright © 2018 The Way 2.0. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewControllerAR: UIViewController, ARSCNViewDelegate {
    
        var ruta = ""

        //etiqueta para indicar al usuario que el plano horizontal ha sido detectadi
        @IBOutlet weak var planeDetected: UILabel!
        //variable para manejar la escena
        @IBOutlet weak var sceneView: ARSCNView!
        let configuration = ARWorldTrackingConfiguration()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            //mostrar el origen y los puntos detectados
            self.sceneView.debugOptions = [ARSCNDebugOptions.showWorldOrigin, ARSCNDebugOptions.showFeaturePoints]
            //indicar la detección del plano
            self.configuration.planeDetection = .horizontal
            self.sceneView.session.run(configuration)
            self.sceneView.delegate = self
            //administrador de gestos para identificar el tap sobre el plano horizontal
            let tap = UITapGestureRecognizer(target: self, action: #selector(tapHandler))
            self.sceneView.addGestureRecognizer(tap)
        }
        //función administradora de gestos
        @objc func tapHandler(sender: UITapGestureRecognizer){
            guard let sceneView = sender.view as? ARSCNView else {return}
            let touchLocation = sender.location(in: sceneView)
            //obtener los resultados del tap sobre el plano horizontal
            let hitTestResult = sceneView.hitTest(touchLocation, types: .existingPlaneUsingExtent)
            if !hitTestResult.isEmpty{
                //cargar la escena
                self.addPortal(hitTestResult: hitTestResult.first!)
            }
            else{
                // no hubo resultado
            }
            
            
        }
        //cargar el portal
        func addPortal(hitTestResult:ARHitTestResult)
        {
            let portalScene = SCNScene(named:"escenes.sncassets/Portal.scn")
            /*var portalScene: SCNScene?
            do {
                portalScene = try SCNScene(url: URL(fileURLWithPath: ruta), options: nil)
            } catch {}*/
            let portalNode = portalScene?.rootNode.childNode(withName: "Portal", recursively: false)
            //convertir las coordenadas del rayo del tap a coordenadas del mundo real
            let transform = hitTestResult.worldTransform
            let planeXposition = transform.columns.3.x
            let planeYposition = transform.columns.3.y
            let planeZposition = transform.columns.3.z
            portalNode?.position = SCNVector3(planeXposition,planeYposition,planeZposition)
            self.sceneView.scene.rootNode.addChildNode(portalNode!)
            
            
            let portalScene2 = SCNScene(named:"art.scnassets/ship.scn")
            /*var portalScene2: SCNScene?
             do {
             portalScene2 = try SCNScene(url: URL(fileURLWithPath: ruta), options: nil)
             } catch {}*/
            let portalNode2 = portalScene2?.rootNode.childNode(withName: "ship", recursively: false)
            //convertir las coordenadas del rayo del tap a coordenadas del mundo real
            let transform2 = hitTestResult.worldTransform
            let planeXposition2 = transform2.columns.3.x
            let planeYposition2 = transform2.columns.3.y + 1
            let planeZposition2 = transform2.columns.3.z
            portalNode2?.position = SCNVector3(planeXposition2,planeYposition2,planeZposition2)
            self.sceneView.scene.rootNode.addChildNode(portalNode2!)
            
        }
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
        //esta funcion indica al delegado que se ha agregado un nuevo nodo en la escena
        /* para mayor detalle https://developer.apple.com/documentation/arkit/arscnview/providing_3d_virtual_content_with_scenekit
         */
        func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
            guard anchor is ARPlaneAnchor else {return} //se agrego un plano
            //ejecución asincrona en donde se modifica la etiqueta de plano detectado
            DispatchQueue.main.async {
                self.planeDetected.isHidden = false
                print("Plano detectado")
            }
            //espera 3 segundos antes de desaparecer
            DispatchQueue.main.asyncAfter(deadline: .now()+3){self.planeDetected.isHidden = true}
        }
        
    @IBAction func pinchGest(_ sender: UIPinchGestureRecognizer) {
        
        let casa = self.sceneView.scene.rootNode.childNode(withName: "ship", recursively: false)
        
        let escala = sender.scale
        print(escala)
        
        casa?.scale.x *= Float(escala)
        casa?.scale.y *= Float(escala)
        casa?.scale.z *= Float(escala)
    }
    
    @IBAction func rotateGest(_ sender: UIRotationGestureRecognizer) {
        print("rotar")
    }
    
    @IBAction func swipeGest(_ sender: UISwipeGestureRecognizer) {
        print("swip")
        let casa = self.sceneView.scene.rootNode.childNode(withName: "ship", recursively: false)
        
        var x = casa?.rotation.z
        
        if(sender.direction == UISwipeGestureRecognizerDirection.left){
            print("izq")
            x = (casa?.rotation.z)! - 0.1
        }else{
            print("der")
            x = (casa?.rotation.z)! + 0.1
        }
        
        casa?.rotation = SCNVector4((casa?.rotation.x)!,(casa?.rotation.y)!,x!, (casa?.rotation.w)!)
    }
    
}
