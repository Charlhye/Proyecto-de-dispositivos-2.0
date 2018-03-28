//
//  TableViewController2.swift
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

class TableViewController2: UITableViewController {
    
    //paso 8: agregar la direccion de donde se recuperan los datos en linea
    let direccion="http://199.233.252.86/datos/datos.json"
    private let datos = [
        "Ford", "BMW", "Audi", "VW", "Chrysler", "Nissan", "Peugeot", "Renault", "Seat", "Citroen"
    ]
    
    //paso 1: agregar nuevos datos en formato JSON
    let datosJSON = "[ {\"Marca\": \"FORD\", \"Agencias\": 21}, {\"marca\": \"BMW\", \"agencias\": 35} ]"
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
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        //nuevoArray = JSONParseArray(datosJSON)
        let url = URL(string: direccion)
        let datos = try? Data(contentsOf: url!)
        
        //paso 4: llenar el nuevo arreglo
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
        let s:String = objetoMarca["marca"] as! String
        cell.textLabel?.text=s
        return cell
        
        // Configure the cell...
        
        /*
         let cell = tableView.dequeueReusableCell(withIdentifier: "entradaMarca", for: indexPath)
         
         // Configure the cell...
         //cell.textLabel?.text = datos[indexPath.row]
         //paso 6: reemplazar el uso de datos por nuevo array
         //objeto marca es un diccionario que contiene marca y agencias
         let objetoMarca = nuevoArray?[indexPath.row] as! [String: Any]
         let s:String = objetoMarca["Marca"] as! String
         
         cell.textLabel?.text=s
         
         return cell
         */
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let sigVista = segue.destination as! DetalleViewController2
        let indice = self.tableView.indexPathForSelectedRow?.row
        //paso 7: reemplazar el uso de datos por nuevoArrat
        //objetoMarca es un diccionario que contiene marca y agencias
        let objetoMarca = nuevoArray![indice!] as! [String: Any]
        let s:String = objetoMarca["marca"] as! String
        
        sigVista.valorRecibido = s
    }
    
    
}

