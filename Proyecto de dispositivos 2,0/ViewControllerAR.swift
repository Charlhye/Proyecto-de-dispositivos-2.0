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
        
    

}
