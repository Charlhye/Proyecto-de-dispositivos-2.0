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
    
    @IBOutlet weak var activityInd: UIActivityIndicatorView!
    var ruta = ""
    var videoadd = ""
    var tresDeRuta = ""
    
    var hasPortal = false
    var hasTresde = false
    var hasVid = false

    //etiqueta para indicar al usuario que el plano horizontal ha sido detectadi
    @IBOutlet weak var planeDetected: UILabel!
    //variable para manejar la escena
    @IBOutlet weak var sceneView: ARSCNView!
    let configuration = ARWorldTrackingConfiguration()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        UIApplication.shared.endIgnoringInteractionEvents()
        self.sceneView.session.run(configuration)
        self.sceneView.delegate = self

    }
    
    var dondeLoPuso: simd_float4x4?
    
    func dondeLoPongo(){
        if(dondeLoPuso == nil){
            guard let currentFrame = self.sceneView.session.currentFrame else {return}
            self.dondeLoPuso = currentFrame.camera.transform
        }
    }
    
    //cargar el portal
    @IBAction func portalHandler(_ sender: UIButton) {
        
        activityInd.startAnimating()
        
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        sleep(1)
        
        DispatchQueue.main.async {
            self.addPortalsup()
        }

    }
    
    func addPortalsup(){
        if !self.hasPortal {
            
            let urlSelectedItem = "http://199.233.252.86/201811/theway2/Assets/Portal.scn"
            let url = URL(string: urlSelectedItem)

            let portalScene = try? SCNScene(url: url!, options: nil)
            
            let portalNode = portalScene?.rootNode.childNode(withName: "Portal", recursively: false)
            
            dondeLoPongo()
            
            var traduccion = matrix_identity_float4x4
            //definir un metro alejado del dispositivo
            //traduccion.columns.3.z = -1.0
            portalNode?.simdTransform = matrix_multiply(self.dondeLoPuso!, traduccion)
            portalNode?.eulerAngles = SCNVector3(0, Double.pi/2, 0)
            portalNode?.position.y = (portalNode?.position.y)! - 1
            
            
            var img = UIImage(data: try! Data(contentsOf: URL(string: "\(self.ruta)/1.png")!))
            portalNode?.childNode(withName: "box", recursively: false)?.geometry?.materials[0].diffuse.contents = img
            
            img = UIImage(data: try! Data(contentsOf: URL(string: "\(self.ruta)/2.png")!))
            portalNode?.childNode(withName: "box", recursively: false)?.geometry?.materials[1].diffuse.contents = img
            
            img = UIImage(data: try! Data(contentsOf: URL(string: "\(self.ruta)/3.png")!))
            portalNode?.childNode(withName: "box", recursively: false)?.geometry?.materials[2].diffuse.contents = img
            
            img = UIImage(data: try! Data(contentsOf: URL(string: "\(self.ruta)/4.png")!))
            portalNode?.childNode(withName: "box", recursively: false)?.geometry?.materials[3].diffuse.contents = img
            
            img = UIImage(data: try! Data(contentsOf: URL(string: "\(self.ruta)/5.png")!))
            portalNode?.childNode(withName: "box", recursively: false)?.geometry?.materials[4].diffuse.contents = img
            
            img = UIImage(data: try! Data(contentsOf: URL(string: "\(self.ruta)/6.png")!))
            portalNode?.childNode(withName: "box", recursively: false)?.geometry?.materials[5].diffuse.contents = img
            
            self.sceneView.scene.rootNode.addChildNode(portalNode!)
            self.hasPortal = true

        } else {
            self.sceneView.scene.rootNode.childNode(withName: "Portal", recursively: false)?.removeFromParentNode()
            
            self.hasPortal = false
        }
        UIApplication.shared.endIgnoringInteractionEvents()
        activityInd.stopAnimating()
    }
    
    @IBAction func tresde(_ sender: UIButton) {
        
        activityInd.startAnimating()
        
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        sleep(1)
        
        DispatchQueue.main.async {
            self.addtresde()
        }
    }
    
    var nombreTresDe = ""
    
    func addtresde(){
        if !hasTresde {
            
            let urlSelectedItem = tresDeRuta
            let url = URL(string: urlSelectedItem)
            
            dondeLoPongo()
            
            let scene = try? SCNScene(url: url!, options: nil)
            let node = scene?.rootNode.childNodes[0]
            nombreTresDe = (node?.name!)!

            var traduccion = matrix_identity_float4x4
            node?.simdTransform = matrix_multiply(dondeLoPuso!, traduccion)
            node?.eulerAngles = SCNVector3(-(Double.pi/2), Double.pi/2, 0)
            
            node?.position.x = (node?.position.x)! - 0.5
            
            self.sceneView.scene.rootNode.addChildNode(node!)
            
            hasTresde = true
        } else {
            self.sceneView.scene.rootNode.childNode(withName: nombreTresDe, recursively: false)?.removeFromParentNode()
            
            hasTresde = false
        }
        UIApplication.shared.endIgnoringInteractionEvents()
        activityInd.stopAnimating()
    }
    
    @IBAction func video(_ sender: UIButton) {
        
        activityInd.startAnimating()
        
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        sleep(1)
        
        DispatchQueue.main.async {
            self.addvideo()
        }
        
       
    }
    
    func addvideo(){
        if !hasVid {
            
            dondeLoPongo()
            
            let currentFrame = dondeLoPuso!
            print(videoadd)
            let moviePath = videoadd
            let url = URL(string: moviePath)
            
            let videoNodo = SKVideoNode(url: url!)
            
            videoNodo.play()
            
            let spriteKitEscene =  SKScene(size: CGSize(width: 640, height: 480))
            spriteKitEscene.addChild(videoNodo)
            
            videoNodo.position = CGPoint(x: spriteKitEscene.size.width/2, y: spriteKitEscene.size.height/2)
            videoNodo.size = spriteKitEscene.size
            
            let pantalla = SCNPlane(width: 1.0, height: 0.75)
            
            pantalla.firstMaterial?.diffuse.contents = spriteKitEscene
            pantalla.firstMaterial?.isDoubleSided = true
            
            let pantallaPlanaNodo = SCNNode(geometry: pantalla)
            pantallaPlanaNodo.name = "pantallaPlanaNodo"
            
            var traduccion = matrix_identity_float4x4
            
            traduccion.columns.3.z = -1.0
            pantallaPlanaNodo.simdTransform = matrix_multiply(currentFrame, traduccion)
            
            pantallaPlanaNodo.eulerAngles = SCNVector3(Double.pi, 0, 0)
            self.sceneView.scene.rootNode.addChildNode(pantallaPlanaNodo)
            
            hasVid = true
            
        }else{
            self.sceneView.scene.rootNode.childNode(withName: "pantallaPlanaNodo", recursively: false)?.removeFromParentNode()
            
            hasVid = false
        }
        UIApplication.shared.endIgnoringInteractionEvents()
        activityInd.stopAnimating()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func pinchGest(_ sender: UIPinchGestureRecognizer) {
        
        let casa = self.sceneView.scene.rootNode.childNode(withName: nombreTresDe, recursively: false)
        
        let escala = sender.scale
        
        casa?.scale.x *= Float(escala)
        casa?.scale.y *= Float(escala)
        casa?.scale.z *= Float(escala)
    }
    
    @IBAction func rotateGest(_ sender: UIRotationGestureRecognizer) {
        let casa = self.sceneView.scene.rootNode.childNode(withName: nombreTresDe, recursively: false)
        
        let escala = sender.rotation
        
        casa?.eulerAngles.y += Float(escala)
    }
}
