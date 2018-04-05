//
//  ProyectosViewController.swift
//  Proyecto de dispositivos 2,0
//
//  Created by Carlos Balcazar on 03/04/18.
//  Copyright © 2018 The Way 2.0. All rights reserved.
//

import UIKit

class ProyectosViewController: UIViewController {

    @IBOutlet weak var username: UITextField!
    
    let direccion = "http://199.233.252.86/201811/data/user.json"
    
    @IBOutlet weak var login: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    var nuevoArray: [String:Any]?
    
    var usuario: Usuario?

    @IBAction func iniciarSesion(_ sender: UIButton) {
        let url = URL(string: direccion)
        let datos = try? Data(contentsOf: url!)
        
        nuevoArray = try! JSONSerialization.jsonObject(with: datos!) as! [String : Any]
        if(username.text! == nuevoArray!["user"] as! String){
            usuario = Usuario(username.text!)
            
            let proyectos = nuevoArray!["projects"] as! [Any]
            //print(proyectos)
            for i in 0..<proyectos.count{
                let proyecto = proyectos[i] as! [String:Any]
                let nombre = proyecto["projectName"]! as! String
                //print(nombre)
                let estado = proyecto["estatus"]! as! String
                //print(estado)
                let recursos = proyecto["resources"] as! [Any]
                var recursos1: [String] = []
                
                for j in 0..<recursos.count{
                    let rec = recursos[j] as! [String:Any]
                    let nom = rec["resourceName"] as! String
                    //print(nom)
                    recursos1.append(nom)
                }
                usuario?.addProyecto(withName: nombre, estado: estado, recs: recursos1)
            }
            segueChafa()

        }else{
            login.isHidden = false
        }
        
    }
    
    func segueChafa(){
        let sigVista = self.storyboard?.instantiateViewController(withIdentifier: "Listaproys") as! TableViewController2
        sigVista.usuario = usuario        
        self.navigationController?.pushViewController(sigVista, animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
