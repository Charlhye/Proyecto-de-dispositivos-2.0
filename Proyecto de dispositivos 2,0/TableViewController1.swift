//
//  TableViewControler1.swift
//  Proyecto de dispositivos 2,0
//
//  Created by Manuel Avalos Tovar on 3/28/18.
//  Copyright © 2018 The Way 2.0. All rights reserved.
//

import UIKit

class TableViewController1: UITableViewController, UISearchResultsUpdating {
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    var stringBusqueda = ""
    var datosFiltrados = [Any]()
    let searchController = UISearchController(searchResultsController: nil)
    
    //UISearchResultsUpdating
    func updateSearchResults(for searchController: UISearchController) {
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
                }
        }
        return [AnyObject]()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        activityIndicator.stopAnimating()
        UIApplication.shared.endIgnoringInteractionEvents()


        let url = URL(string: direccion)
        let datos = try? Data(contentsOf: url!)

        nuevoArray = try! JSONSerialization.jsonObject(with: datos!) as? [Any]
        
        searchController.searchBar.text! = stringBusqueda
        
        datosFiltrados = nuevoArray!
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        definesPresentationContext = true
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
       return (datosFiltrados.count)
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "zelda", for: indexPath)
        
        if (cell == nil) {
            cell = UITableViewCell(
                style: UITableViewCellStyle.default, reuseIdentifier: "zelda")
        }
        
        let objetoMarca = datosFiltrados[indexPath.row] as! [String: Any]
        let s:String = objetoMarca["nombre"] as! String
        cell.textLabel?.text=s
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        tableView.tableFooterView = activityIndicator
                
        activityIndicator.center = (tableView.tableFooterView?.center)!
        
        activityIndicator.startAnimating()

        
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        let indice = indexPath.row
        
        seguechafa(indice)
        
    }
    
    func seguechafa(_ indice: Int){
        var objetoMarca = [String:Any]()
        
        let sigVista = self.storyboard?.instantiateViewController(withIdentifier: "Detalle") as! SalonViewController
        
        if (self.searchController.isActive)
        {
            objetoMarca = datosFiltrados[indice] as! [String: Any]
            
        }
        else
        {
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
        let video:String = objetoMarca["video"] as! String
        
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
        sigVista.video = video
        
        self.navigationController?.pushViewController(sigVista, animated: true)
    }
    
}
