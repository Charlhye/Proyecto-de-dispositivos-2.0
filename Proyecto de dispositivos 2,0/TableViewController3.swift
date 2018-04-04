//
//  TableViewController3.swift
//  Proyecto de dispositivos 2,0
//
//  Created by CDT307 on 4/4/18.
//  Copyright © 2018 The Way 2.0. All rights reserved.
//

import UIKit

class TableViewController3: UITableViewController, UISearchResultsUpdating  {

    //paso 2: crear una variable para almacenar lo datos que son filtrados
    var datosFiltrados: [String]?
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
                let objetoMarca=$0 as! String;
                let s:String = objetoMarca;
                return(s.lowercased().contains(searchController.searchBar.text!.lowercased())) }
        }
        
        self.tableView.reloadData()
    }
    
    var nuevoArray:[String]?
    
    var proyecto: Usuario.proyecto?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nuevoArray = proyecto?.recursos
        
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
        return (datosFiltrados!.count)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "zelda", for: indexPath)
        
        
        if (cell == nil) {
            cell = UITableViewCell(
                style: UITableViewCellStyle.default, reuseIdentifier: "zelda")
        }
        //paso 12 remplazar el uso de nuevoArray por datosFitrados
        //Usar el objeto marca para la obtencion de los datos
        let objetoMarca = datosFiltrados![indexPath.row]
        let s:String = objetoMarca
        cell.textLabel?.text=s
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var indice = 0
        var objetoMarca: String?
        //Paso 15: crear un identificador para el controlador de vista a nivel detalle
        let sigVista = self.storyboard?.instantiateViewController(withIdentifier: "ListaNormal") as! TableViewController1
        //Verificar si la vista actual es la de búsqueda
        if (self.searchController.isActive)
        {
            indice = indexPath.row
            objetoMarca = datosFiltrados![indice]
            sigVista.stringBusqueda = objetoMarca!
        }
            //sino utilizar la vista sin filtro
        else
        {
            indice = indexPath.row
            objetoMarca = nuevoArray![indice]
            sigVista.stringBusqueda = objetoMarca!
        }
        
        self.navigationController?.pushViewController(sigVista, animated: true)
        
    }
    
    // MARK: - Navigation
    /*
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
     }*/

}
