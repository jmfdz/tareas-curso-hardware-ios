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
        // Do any additional setup after loading the view, typically from a nib.
        do {
            try reproductor = AVAudioPlayer(contentsOf: cancion1)
        } catch {
            print("Error de cancion")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

    
    func cambiarCancion(numero : Int) -> Void {
        titulo.text = "Título canción \(numero)"
        portada.image = UIImage(named: "cancion\(numero)")
        
        switch (numero){
        case 1 : do {
                try reproductor = AVAudioPlayer(contentsOf: cancion1)
        }catch {
            print("Error al cambiar de cancion")
        }
        case 2 : do {
            try reproductor = AVAudioPlayer(contentsOf: cancion2)
        }catch {
            print("Error al cambiar de cancion")
        }
        case 3 : do {
            try reproductor = AVAudioPlayer(contentsOf: cancion3)
        }catch {
            print("Error al cambiar de cancion")
        }
        default : print("Ninguna canción")
        }
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
    
}

