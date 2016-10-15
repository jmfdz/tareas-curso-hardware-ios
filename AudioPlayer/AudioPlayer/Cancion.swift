//
//  Cancion.swift
//  AudioPlayer
//
//  Created by Jose Maria Fernandez on 15/10/16.
//  Copyright © 2016 Universidad de Alicante. All rights reserved.
//

import Foundation

class Cancion {
    var titulo : String
    var rutaCancion : String
    var rutaPortada : String
    
    init(titulo : String, rutaCancion : String, rutaPortada : String){
        self.titulo = titulo
        self.rutaCancion = rutaCancion
        self.rutaPortada = rutaPortada
    }
}

class Canciones {
    var lista : [Cancion] = [Cancion]()
    var indice : Int = 0
    
    func añadirCancion(cancion : Cancion){
        self.lista.append(cancion)
    }
    func cambiarIndice(indice : Int){
        self.indice = indice
    }
    func cambiarSiguiente(){
        if self.indice < 4 {
            self.indice += 1
        }else {
            self.indice = 0
        }
    }
    func cambiarAleatoria(){
        self.indice =  Int( arc4random()) % self.lista.count
    }
    func reproducirCancion(indice : Int) -> Cancion {
        return self.lista[indice]
    }
    func reproducirCancionActual() -> Cancion {
        return self.lista[self.indice]
    }
   
}
