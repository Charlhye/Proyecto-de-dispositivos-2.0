//
//  Usuario.swift
//  Proyecto de dispositivos 2,0
//
//  Created by Carlos Balcazar on 04/04/18.
//  Copyright © 2018 The Way 2.0. All rights reserved.
//

import Foundation

class Usuario{
    var nombre: String
    
    struct proyecto {
        var nombre: String
        var status: String
        var recursos: [String]
    }
    
    var proyectos: [proyecto]
    
    func addProyecto(withName name: String, estado: String, recs: [String]){
        let temp = proyecto(nombre: name, status: estado, recursos: recs)
        proyectos.append(temp)
    }
    
    func obtenerProyecto()->proyecto{
        return proyectos.popLast()!
    }
    
    init(_ nombre: String) {
        self.nombre = nombre
        proyectos = []
    }
}
