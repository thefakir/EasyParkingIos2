//
//  ViewController.swift
//  webApi3
//
//  Created by internet on 5/20/15.
//  Copyright (c) 2015 internet. All rights reserved.
//

import UIKit
import SwiftHTTP
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate  {
    @IBOutlet weak var mapView: MKMapView!
 let locationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       /* var parser = Parser();
        for item in parser.getParkings()
        {
        println(item.ParkingName)
        // Do any additional setup after loa    "http://www.easyparking.somee.com/api/parking"
    }
        */
        
        self.mapView.mapType = MKMapType.Standard
        self.mapView.showsUserLocation = true
        self.mapView.removeAnnotations(self.mapView.annotations)
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
      
        
        var request = HTTPTask()
        var jsonOptionalRes: AnyObject! = nil
        // call method Get
        request.GET("http://www.easyparking.somee.com/api/parking", parameters: nil, success: {(response: HTTPResponse) in
            // data is the stream that return the server
            if let data = response.responseObject as? NSData {
                // convert data to String
                let str = NSString(data: data, encoding: NSUTF8StringEncoding)
                println("response: \(str)") //prints the HTML of the page
                // error handler
                var jsonErrorOptional: NSError?
                // parse to JSON
                let jsonOptional = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &jsonErrorOptional)
                // Convert JSON to Array [ { }, {json}]
                if let statusArray: Array<AnyObject> = jsonOptional as? Array{      // iterate array
                    for rest in statusArray{
                        // map json to Resturant object
                        var parking = Parking();
                        var localization = Localization();
                        parking.ParkingName = rest["ParkingName"] as String;
                        parking.OpeningTime = rest["OpeningTime"] as String;
                        parking.ClosingTime = rest["ClosingTime"] as String;
                        parking.Rate = rest["Rate"] as Double;
                        parking.CarSpacesTotal = rest["CarSpacesTotal"] as Int;
                        parking.MotorBikeSpacesTotal = rest["MotorBikeSpacesTotal"] as Int;
                        parking.CarSpacesAvailable = rest["CarSpacesAvailable"] as Int;
                        parking.MotorBikeSpacesAvailable = rest["MotorBikeSpacesAvailable"] as Int;
                        parking.MotorBikeSpacesTotal = rest["MotorBikeSpacesTotal"] as Int;
                        var la = ""
                        var lo = ""
                        
                        
                        if let localiza = rest["Local"] as? NSDictionary {
                            la = localiza["Latitude"] as String
                            lo = localiza["Longitude"] as String
                            //etc, etc
                        }
                        
                        parking.Local.Latitude = (la as NSString).doubleValue
                        parking.Local.Longitude = (lo as NSString).doubleValue
                        
                        
                        let location = CLLocationCoordinate2D(latitude:  parking.Local.Latitude, longitude: parking.Local.Longitude);
                        // Add an annotation on Map View
                        var point: MKPointAnnotation! = MKPointAnnotation()
                        
                        point.setCoordinate(location)
                        point.title = parking.ParkingName
                        
                        var carTile = "Autos: ";
                        var motoTitle = "Motos: ";
                        var tarifa = "Tarifa: ";
                        point.subtitle = carTile + "\(parking.CarSpacesAvailable)/\(parking.CarSpacesTotal)--"
                        + motoTitle + "\(parking.MotorBikeSpacesAvailable)/\(parking.MotorBikeSpacesTotal)--"
                        + tarifa + "\(parking.Rate)Bs"
                      
                         self.mapView.addAnnotation(point)
                        println(parking.ParkingName)
                        
                    }
                }

                
            }
            },failure: {(error: NSError, response: HTTPResponse?) in
                println("error: \(error)")
                
        })

        
        
        }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
      
    }

    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        println("error")
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        let userLocation = locations[0] as CLLocation
        locationManager.stopUpdatingLocation()
        let location  = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
        let span = MKCoordinateSpanMake(0.05,0.05);
        
        let region = MKCoordinateRegion(center: location, span: span);
        self.mapView.setRegion(region, animated: true)
        /*
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        
        self.mapView.setRegion(region, animated: true)
        
        
        // Add an annotation on Map View
        var point: MKPointAnnotation! = MKPointAnnotation()
        
        point.coordinate = location.coordinate
        point.title = "Current Location"
        point.subtitle = "sub title"
        
        self.mapView.addAnnotation(point)
        
        //stop updating location to save battery life
        locationManager.stopUpdatingLocation()
        
        */
    }

}

