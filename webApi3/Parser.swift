//
//  Parser.swift
//  webApi3
//
//  Created by internet on 5/23/15.
//  Copyright (c) 2015 internet. All rights reserved.
//
import UIKit
import SwiftHTTP
class Parser: NSObject {
    
    var _parkingName = "";
    var _openingTime = "";

    
    override init(){
}
    
    func sayHello(personName: String) -> String {
        let greeting = "Hello, " + personName + "!"
        return greeting
    }
    func list() -> [String] {
        let list = ["uno", "dos"]
        return list
    }
    func getJson(url:String) -> AnyObject! {
        
        var request = HTTPTask()
        var jsonOptionalRes: AnyObject! = nil
        // call method Get
        request.GET(url, parameters: nil, success: {(response: HTTPResponse) in
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
                dispatch_async(dispatch_get_main_queue(),{
                    jsonOptionalRes = jsonOptional

                })
                
            }
            },failure: {(error: NSError, response: HTTPResponse?) in
                println("error: \(error)")
                
        })
        return jsonOptionalRes;

        }
    func getParkings() -> [Parking] {
        var parkings : [Parking]=[]
        let jsonOptional: AnyObject! = getJson("http://www.easyparking.somee.com/api/parking")
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
                parking.MotorBikeSpacesTotal = rest["CarSpacesAvailable"] as Int;
                parking.MotorBikeSpacesTotal = rest["MotorBikeSpacesAvailable"] as Int;
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
                
                parkings.append(parking);
                
                println(parking.ParkingName)

            }
        }

        return parkings
    }
    
    /*
    var request = HTTPTask()
    // call method Get
    request.GET("http://www.easyparking.somee.com/api/parking", parameters: nil, success: {(response: HTTPResponse) in
    // data is the stream that return the server
    if let data = response.responseObject as? NSData {
    // convert data to String
    let str = NSString(data: data, encoding: NSUTF8StringEncoding)
    //println("response: \(str)") //prints the HTML of the page
    // error handler
    var jsonErrorOptional: NSError?
    // parse to JSON
    let jsonOptional: AnyObject! = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &jsonErrorOptional)
    // Convert JSON to Array [ { }, {json}]
    if let statusArray: Array<AnyObject> = jsonOptional as? Array{      // iterate array
    for rest in statusArray{
    // map json to Resturant object
    var parking = Parking();
    var localization = Localization();
    //let restaurant:Restaurant = Mapper<Restaurant>().map(rest)!
    // println("rest \(restaurant.name)")
    // var name = restaurant.name
    // println(rest["ParkingName"])
    //self.nameRest.text = name!
    parking.ParkingName = rest["ParkingName"] as String;
    parking.OpeningTime = rest["OpeningTime"] as String;
    parking.ClosingTime = rest["ClosingTime"] as String;
    parking.Rate = rest["Rate"] as Double;
    parking.CarSpacesTotal = rest["CarSpacesTotal"] as Int;
    parking.MotorBikeSpacesTotal = rest["MotorBikeSpacesTotal"] as Int;
    parking.MotorBikeSpacesTotal = rest["CarSpacesAvailable"] as Int;
    parking.MotorBikeSpacesTotal = rest["MotorBikeSpacesAvailable"] as Int;
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
    
    
    println(parking.ParkingName)
    println(parking.Local.Latitude)
    println(parking.Local.Longitude)
    }
    }
    
    
    }
    },failure: {(error: NSError, response: HTTPResponse?) in
    println("error: \(error)")
    })
    */
    

}
