//
//  SalonViewController.swift
//  Proyecto de dispositivos 2,0
//
//  Created by Carlos Balcazar on 29/03/18.
//  Copyright © 2018 The Way 2.0. All rights reserved.
//

import UIKit

class SalonViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    struct maquina{
        var nombre: String
        var marca : String
        var modelo: String
        var tresde: String
        var video : String
    }
    
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
    var maquinaria: [maquina] = [maquina]()
    
    @IBOutlet weak var descripcionlb: UILabel!
    @IBOutlet weak var locacionlb: UILabel!
    @IBOutlet weak var responsablelb: UILabel!
    @IBOutlet weak var horaAplb: UILabel!
    @IBOutlet weak var horaCilb: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var maquinasCb: UIPickerView!
    
    @IBOutlet weak var activityInd: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.endIgnoringInteractionEvents()
        
        descripcionlb.text! = descripcion
        locacionlb.text! = "Salon: \(locacionPlanta)\(locacionSalon)"
        responsablelb.text! = "Contacto\n\(responsableNombre)\n\(responsableTelefono)\n\(responsableCorreo)"
        horaAplb.text! = "Apertura: \(horaApertura)"
        horaCilb.text! = "Cierre: \(horaCierre)"
        
        
        
        let url = URL(string: fotografia)
        let data = try? Data(contentsOf: url!)
        let img = UIImage(data: data!)
        imageView.image =
            img!

        // Do any additional setup after loading the view.
        
        self.maquinasCb.delegate = self
        self.maquinasCb.dataSource = self
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
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return maquinaria.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return maquinaria[row].nombre+" "+maquinaria[row].marca+" "+maquinaria[row].modelo
    }
    
    var selectedRow = 0
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedRow = row
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        activityInd.startAnimating()
        
        let sigVista = segue.destination as! TutorialARViewController
        sigVista.ruta = foto360
        sigVista.videoadd = maquinaria[selectedRow].video
    }
    

}
