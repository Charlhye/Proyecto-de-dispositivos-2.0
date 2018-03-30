//
//  TableViewController1TableViewController.swift
//  Proyecto de dispositivos 2,0
//
//  Created by Manuel Avalos Tovar on 3/28/18.
//  Copyright © 2018 The Way 2.0. All rights reserved.
//

//
//  TableViewControler1.swift
//  Proyecto de dispositivos 2,0
//
//  Created by Manuel Avalos Tovar on 3/28/18.
//  Copyright © 2018 The Way 2.0. All rights reserved.
//

import UIKit

class TableViewController1: UITableViewController {
    
    //paso 8: agregar la direccion de donde se recuperan los datos en linea
    let direccion="http://199.233.252.86/201811/theway2/labsCDETEClleno.json"
    
    //paso 2: declarar una variable para contener los nuevos datos
    var nuevoArray:[Any]?
    
    //paso 3: incluir una funci[on que convierta de JSON a Array
    func JSONParseArray(_ string: String) -> [AnyObject]{
        if let data = string.data(using: String.Encoding.utf8){
            
            do{
                
                if let array = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)  as? [AnyObject] {
                    return array
                }
            }catch{
                
                print("error")
                //handle errors here
                
            }
        }
        return [AnyObject]()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let url = URL(string: direccion)
        let datos = try? Data(contentsOf: url!)

        nuevoArray = try! JSONSerialization.jsonObject(with: datos!) as? [Any]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        //paso 5: remplazar el uso de datos por nuevo array
        return nuevoArray!.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "zelda", for: indexPath)
        
        
        if (cell == nil) {
            cell = UITableViewCell(
                style: UITableViewCellStyle.default, reuseIdentifier: "zelda")
        }
        let objetoMarca = nuevoArray![indexPath.row] as! [String: Any]
        let s:String = objetoMarca["nombre"] as! String
        cell.textLabel?.text=s
        return cell
        
    }
  
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let sigVista = segue.destination as! SalonViewController
        let indice = self.tableView.indexPathForSelectedRow?.row
        let objetoMarca = nuevoArray![indice!] as! [String: Any]
        
        let nombre:String = objetoMarca["nombre"] as! String
        let locacionPlanta:String = objetoMarca["locacionPlanta"] as! String
        let locacionSalon:String = objetoMarca["locacionSalon"] as! String
        let responsableNombre:String = objetoMarca["responsableNombre"] as! String
        let responsableTelefono:String = objetoMarca["responsableTelefono"] as! String
        let responsableCorreo:String = objetoMarca["responsableCorreo"] as! String
        let descripcion:String = objetoMarca["descripcion"] as! String
        let horaApertura:String = objetoMarca["horarioApertura"] as! String
        let horaCierre:String = objetoMarca["horaCierre"] as! String
        let fotografia:String = objetoMarca["fotografia"] as! String
        let foto360:String = objetoMarca["foto360"] as! String
        
        sigVista.nombre = nombre
        sigVista.locacionPlanta = locacionPlanta
        sigVista.locacionSalon = locacionSalon
        sigVista.responsableNombre = responsableNombre
        sigVista.responsableTelefono = responsableTelefono
        sigVista.responsableCorreo = responsableCorreo
        sigVista.descripcion = descripcion
        sigVista.horaApertura = horaApertura
        sigVista.horaCierre = horaCierre
        sigVista.fotografia = fotografia
        sigVista.foto360 = foto360
    }
    
    
}

