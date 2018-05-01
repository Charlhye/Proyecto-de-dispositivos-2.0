//
//  MapaViewController.swift
//  Proyecto de dispositivos 2,0
//
//  Created by Carlos Balcazar on 01/05/18.
//  Copyright © 2018 The Way 2.0. All rights reserved.
//

import MapKit
import CoreLocation
import UIKit

class MapaViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var mapa: MKMapView!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 1000.0
        locationManager.requestWhenInUseAuthorization()
        
        
        mapa.mapType=MKMapType.standard
        let cl=CLLocationCoordinate2DMake(19.283996, -99.136006)
        mapa.region=MKCoordinateRegionMakeWithDistance(cl, 2000, 2000)
        /* //esta es otra forma de definir la región de un mapa
         let origen=CLLocationCoordinate2DMake(0.0, 0.0)
         let delta=CLLocationDegrees(0.01)
         let span=MKCoordinateSpanMake(delta, delta)
         let region=MKCoordinateRegionMake(cl, span)
         mapa.setRegion(region, animated: true)
         */
        var punto = CLLocationCoordinate2D()
        punto.latitude = 19.283996
        punto.longitude = -99.136006
        let pin = MKPointAnnotation()
        pin.coordinate = punto
        pin.title = "Cedetec CCM"
        pin.subtitle = "Ciudad de Mexico"
        mapa.addAnnotation(pin)
        
        
        mapa.showsCompass=true
        mapa.showsScale=true
        mapa.showsTraffic=true
        mapa.isZoomEnabled=true
        
    }
    
    func locationManager(_ manager: CLLocationManager,
                         didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse{
            locationManager.startUpdatingLocation()
            mapa.showsUserLocation = true
        } else {
            locationManager.stopUpdatingLocation()
            mapa.showsUserLocation = false
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func openInMaps(_ sender: Any) {
        let latitude: CLLocationDegrees = 19.283996
        let longitude: CLLocationDegrees = -99.136006
        
        let regionDistance:CLLocationDistance = 10000
        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
        let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates, regionDistance, regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = "Cedetec CCM"
        mapItem.openInMaps(launchOptions: options)
    }
    

}
