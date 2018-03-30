//
//  SalonViewController.swift
//  Proyecto de dispositivos 2,0
//
//  Created by Carlos Balcazar on 29/03/18.
//  Copyright © 2018 The Way 2.0. All rights reserved.
//

import UIKit

class SalonViewController: UIViewController {
    
    var nombre = ""
    var locacionPlanta = ""
    var locacionSalon = ""
    var responsableNombre = ""
    var responsableTelefono = ""
    var responsableCorreo = ""
    var descripcion = ""
    var horaApertura = ""
    var horaCierre = ""
    var fotografia = ""
    var foto360 = ""
    
    @IBOutlet weak var descripcionlb: UILabel!
    @IBOutlet weak var locacionlb: UILabel!
    @IBOutlet weak var responsablelb: UILabel!
    @IBOutlet weak var horaAplb: UILabel!
    @IBOutlet weak var horaCilb: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(fotografia)
        
        descripcionlb.text! = descripcion
        locacionlb.text! = "\(locacionPlanta)\(locacionSalon)"
        responsablelb.text! = "\(responsableNombre)\n\(responsableTelefono)\n\(responsableCorreo)"
        horaAplb.text! = "\(horaApertura)"
        horaCilb.text! = "\(horaCierre)"
        
        
        
        let url = URL(string: fotografia)
        let data = try? Data(contentsOf: url!)
        let img = UIImage(data: data!)
        imageView.image =
            img!

        // Do any additional setup after loading the view.
    }

    @IBAction func compartir(_ sender: Any) {
        
        
        let objetos:[AnyObject]=["Estoy en el aula \(locacionlb.text!): \(nombre)!" as AnyObject]
            
        let actividad=UIActivityViewController(activityItems: objetos,applicationActivities: nil)
            
        actividad.excludedActivityTypes=[UIActivityType.mail]
        self.present(actividad,animated:true, completion:nil)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let sigVista = segue.destination as! ViewControllerAR
        
        sigVista.ruta = foto360
    }
    

}
