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

//paso 1: agregar el protocolo UISearchResultsUpdating
class TableViewController1: UITableViewController, UISearchResultsUpdating {
    //paso 2: crear una variable para almacenar lo datos que son filtrados
    var datosFiltrados = [Any]()
    //paso 3: crear un control de búsqueda
    let searchController = UISearchController(searchResultsController: nil)
    
    //paso 4: crear la función updateSearchResults para cumplir con el protocolo
    //UISearchResultsUpdating
    func updateSearchResults(for searchController: UISearchController) {
        
        // si la caja de búsuqeda es vacía, entonces mostrar todos los resultados
        if searchController.searchBar.text! == "" {
            datosFiltrados = nuevoArray!
        } else {
            // Filtrar los resultados de acuerdo al texto escrito en la caja que es obtenido a través del parámetro $0
            datosFiltrados = nuevoArray!.filter {
                let objetoMarca=$0 as! [String:Any];
                let s:String = objetoMarca["nombre"] as! String;
                return(s.lowercased().contains(searchController.searchBar.text!.lowercased())) }
        }
        
        self.tableView.reloadData()
    }
    
    let direccion="http://199.233.252.86/201811/theway2/labsCDETEClleno.json"
    
    var nuevoArray:[Any]?
    
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
        
        //paso 5: copiar el contenido del arreglo en el arreglo filtrado
        datosFiltrados = nuevoArray!
        
        //Paso 6: usar la vista actual para presentar los resultados de la búsqueda
        searchController.searchResultsUpdater = self
        //paso 7: controlar el background de los datos al momento de hacer la búsqueda
        searchController.dimsBackgroundDuringPresentation = false
        //Paso 8: manejar la barra de navegación durante la busuqeda
        searchController.hidesNavigationBarDuringPresentation = false
        //Paso 9: Definir el contexto de la búsqueda
        definesPresentationContext = true
        //Paso 10: Instalar la barra de búsqueda en la cabecera de la tabla
        tableView.tableHeaderView = searchController.searchBar
        //El re-uso de las celdas se puede realizar de manera programática a través del registro de la celda
        //self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "EntradaMarca")
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
        //paso 11 remplazar el uso de nuevoArray por datosFiltrados
       return (datosFiltrados.count)
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "zelda", for: indexPath)
        
        
        if (cell == nil) {
            cell = UITableViewCell(
                style: UITableViewCellStyle.default, reuseIdentifier: "zelda")
        }
        
        //paso 12 remplazar el uso de nuevoArray por datosFitrados
        //Usar el objeto marca para la obtencion de los datos
        let objetoMarca = datosFiltrados[indexPath.row] as! [String: Any]
        let s:String = objetoMarca["nombre"] as! String
        cell.textLabel?.text=s
        return cell
        
    }
  
    
    
    // MARK: - Navigation
    
    /*
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
     */
    
    //Paso 13: eliminar el segue de entre la tabla y el detalle
    //Paso 14: crear la funcion disSelectRow
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var indice = 0
        var objetoMarca = [String:Any]()
        //Paso 15: crear un identificador para el controlador de vista a nivel detalle
        let sigVista = self.storyboard?.instantiateViewController(withIdentifier: "Detalle") as! SalonViewController
        //Verificar si la vista actual es la de búsqueda
        if (self.searchController.isActive)
        {
            indice = indexPath.row
            objetoMarca = datosFiltrados[indice] as! [String: Any]
            
        }
            //sino utilizar la vista sin filtro
        else
        {
            indice = indexPath.row
            objetoMarca = nuevoArray![indice] as! [String: Any]
        }
        
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
        
        self.navigationController?.pushViewController(sigVista, animated: true)
        
    }
    
}

