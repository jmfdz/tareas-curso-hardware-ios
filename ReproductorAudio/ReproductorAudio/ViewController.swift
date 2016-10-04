//
//  ViewController.swift
//  ReproductorAudio
//
//  Created by Jose Maria Fernandez Gil on 3/10/16.
//  Copyright © 2016 Universidad de Alicante. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var titulo: UILabel!
    @IBOutlet weak var portada: UIImageView!
    
    var cancion1 = URL(fileURLWithPath: Bundle.main.path(forResource: "cancion1", ofType: "m4a")!)
    var cancion2 = URL(fileURLWithPath: Bundle.main.path(forResource: "cancion2", ofType: "m4a")!)
    var cancion3 = URL(fileURLWithPath: Bundle.main.path(forResource: "cancion3", ofType: "m4a")!)
    
    var reproductor : AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        asignarCancion(url: cancion1)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func reproducir() {
        if !reproductor.isPlaying {
            reproductor.play()
        }
    }
    @IBAction func pausar() {
        if reproductor.isPlaying {
            reproductor.pause()
        }
    }
    @IBAction func detener() {
        if reproductor.isPlaying {
            reproductor.stop()
            reproductor.currentTime = 0.0
        }
    }

    @IBAction func cancionAleatoria() {
        var numero : Int = 0
        
        repeat {
            numero = Int(arc4random()) % 4
        } while numero <= 0 && numero > 3
        
        cambiarCancion(numero: numero)
    }
    
    func cambiarCancion(numero : Int) -> Void {
        titulo.text = "Título canción \(numero)"
        portada.image = UIImage(named: "cancion\(numero)")
        
        detener()
        
        switch (numero){
        case 1 : asignarCancion(url: cancion1)
        case 2 : asignarCancion(url: cancion2)
        case 3 : asignarCancion(url: cancion3)
        default : print("Ninguna canción a reproducir")
        }
        
        reproducir()
    }
    
    @IBAction func botonCancion1() {
        cambiarCancion(numero: 1)
    }
    @IBAction func botonCancion2() {
        cambiarCancion(numero: 2)
    }
    @IBAction func botonCancion3() {
        cambiarCancion(numero: 3)
    }
    
    func asignarCancion(url : URL) -> Void {
        do {
            try reproductor = AVAudioPlayer(contentsOf: url)
        }catch {
            print("Error al reproducir canción \(url)")
        }
    }
    
}

