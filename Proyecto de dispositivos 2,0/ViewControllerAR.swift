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
    
    //cargar el portal
    @IBAction func portalHandler(_ sender: UIButton) {
        
        activityInd.startAnimating()
        
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        sleep(1)
        
        DispatchQueue.main.async {
            self.addPortalsup()
        }

    }
    
    var dondeLoPuso: simd_float4x4?
    
    func addPortalsup(){
        if !self.hasPortal {
            let portalScene = SCNScene(named:"escenes.sncassets/Portal.scn")
            
            let portalNode = portalScene?.rootNode.childNode(withName: "Portal", recursively: false)
            
            guard let currentFrame = self.sceneView.session.currentFrame else {return}
            self.dondeLoPuso = currentFrame.camera.transform
            
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
    
    func addtresde(){
        if !hasTresde && hasPortal {
            
            
//            let urlString = "http://199.233.252.89/201811/petitcats/iMacAK.scn"
//            let url = URL.init(string: urlString)
//            let request = URLRequest(url: url!)
//            let session = URLSession.shared
//            let downloadTask = session.downloadTask(with: request,
//                                                    completionHandler: { (location:URL?, response:URLResponse?, error:Error?)
//                                                        -> Void in
//                                                        print("location:\(String(describing: location))")
//                                                        let locationPath = location!.path
//                                                        let documents:String = NSHomeDirectory() + "/Documents/iMacAK.scn"
//                                                        let fileManager = FileManager.default
//                                                        if (fileManager.fileExists(atPath: documents)){
//                                                            try! fileManager.removeItem(atPath: documents)
//                                                        }
//                                                        try! fileManager.moveItem(atPath: locationPath, toPath: documents)
//                                                        print("new location:\(documents)")
//                                                        let scene = try SCNScene(url: URL(fileURLWithPath: documents), options: nil)
//                                                        let nodess = scene.rootNode.childNodes[0]
//                                                        self.sceneView.scene.rootNode.addChildNode(nodess)
//
//                                                        } as! (URL?, URLResponse?, Error?) -> Void)
//            downloadTask.resume()
            
            
            let portalScene2 = SCNScene(named:"art.scnassets/ship.scn")

            let portalNode2 = portalScene2?.rootNode.childNode(withName: "ship", recursively: false)

            var traduccion = matrix_identity_float4x4
            portalNode2?.simdTransform = matrix_multiply(dondeLoPuso!, traduccion)
            portalNode2?.eulerAngles = SCNVector3(0, Double.pi/2, 0)

            portalNode2?.position.y = (portalNode2?.position.y)! - 0.5

            self.sceneView.scene.rootNode.addChildNode(portalNode2!)
            
            hasTresde = true
        } else {
            self.sceneView.scene.rootNode.childNode(withName: "ship", recursively: false)?.removeFromParentNode()
            
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
        if !hasVid && hasPortal {
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
        
        let casa = self.sceneView.scene.rootNode.childNode(withName: "ship", recursively: false)
        
        let escala = sender.scale
        print(escala)
        
        casa?.scale.x *= Float(escala)
        casa?.scale.y *= Float(escala)
        casa?.scale.z *= Float(escala)
    }
    
    @IBAction func rotateGest(_ sender: UIRotationGestureRecognizer) {
        print("rotar")
        let casa = self.sceneView.scene.rootNode.childNode(withName: "ship", recursively: false)
        
        let escala = sender.rotation
        print(escala)
        
        casa?.eulerAngles.y += Float(escala)
    }
}
