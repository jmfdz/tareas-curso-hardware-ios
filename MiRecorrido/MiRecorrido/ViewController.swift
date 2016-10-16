//
//  ViewController.swift
//  MiRecorrido
//
//  Created by Jose Maria Fernandez on 16/10/16.
//  Copyright © 2016 Universidad de Alicante. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var mapa: MKMapView!
    let clManager = CLLocationManager()
    var ultimaPosicion : CLLocation? = nil
    var distancia = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        clManager.delegate = self
        clManager.desiredAccuracy = kCLLocationAccuracyBest
        clManager.requestWhenInUseAuthorization()
        mapa.isZoomEnabled = true        
        mapa.setZoomByDelta(delta: 0.00005, animated: true )
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        if status == .authorizedWhenInUse {
            clManager.startUpdatingLocation()
            
            
            mapa.showsUserLocation = true
        }else {
            clManager.stopUpdatingLocation()
            mapa.showsUserLocation = false
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        mapa.centerCoordinate = manager.location!.coordinate
        
        if self.ultimaPosicion != nil {
            let distancia = manager.location?.distance(from: self.ultimaPosicion!)
            if distancia!.binade >= 50.0 {
                añadirPunto(location: manager.location!)
            }
            
        }else {
            añadirPunto(location: manager.location!)
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Mi error \(error)")
    }
    
    func añadirPunto(location : CLLocation){
        
        let pin = MKPointAnnotation()
        pin.title = "\(location.coordinate.longitude), \(location.coordinate.latitude)"
        pin.subtitle = "\(distancia) metros"
        pin.coordinate = location.coordinate
         
        mapa.addAnnotation(pin)
        
        self.ultimaPosicion = location
        self.distancia += 50
        
    }
    @IBAction func mapaNormal() {
        self.mapa.mapType = .standard
    }
    
    @IBAction func mapaSatelite() {
        self.mapa.mapType = .satellite
    }

    @IBAction func mapaHibrido() {
        self.mapa.mapType = .hybrid
        
    }
}

