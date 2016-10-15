//
//  DetailViewController.swift
//  AudioPlayer
//
//  Created by Jose Maria Fernandez on 15/10/16.
//  Copyright © 2016 Universidad de Alicante. All rights reserved.
//

import UIKit
import AVFoundation

class DetailViewController: UIViewController {

    @IBAction func volumen(_ sender: UISlider) {
        volumen = sender.value
        reproductor.volume = volumen
    }
    
    @IBOutlet weak var titulo: UILabel!
    @IBOutlet weak var portada: UIImageView!
    
    @IBAction func reproducir() {
        if !reproductor.isPlaying {
            reproductor.play()
        }
    }
    @IBAction func pausa() {
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
    @IBAction func siguiente() {
        detailItem?.cambiarSiguiente()
        reproducirCancion()
        self.reproducir()
    }

    var reproductor : AVAudioPlayer!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        reproducirCancion()
        reproducir()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    var detailItem: Canciones?
    var volumen : Float = 5.0

    func reproducirCancion() -> Void {
        print("voy a reproducir")
        if reproductor != nil {
            print("Pero antes detengo")            
            detener()
        }
        
        let cancion = detailItem?.reproducirCancionActual()
        let url = URL(fileURLWithPath: Bundle.main.path(forResource: cancion?.rutaCancion, ofType: "m4a")!)
        
        self.titulo.text = cancion?.titulo
        self.portada.image = UIImage(named: (cancion?.rutaPortada)!)
        
        do {
            try reproductor = AVAudioPlayer(contentsOf: url)
            reproductor.volume = volumen
        }catch {
            print("Error al reproducir canción")
        }
    }
    
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            self.siguiente()
        }
    }

    override func viewDidDisappear(_ animated: Bool) {
        self.detener()
    }
    
}

