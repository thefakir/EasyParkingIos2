//
//  Parking.swift
//  webApi3
//
//  Created by internet on 5/21/15.
//  Copyright (c) 2015 internet. All rights reserved.
//


import UIKit

class Parking: NSObject {
    
    var _parkingName = "";
    var _openingTime = "";
    var _closingTime = "";
    var _rate = 0.0;
    var _carSpacesTotal = 0;
    var _motorBikeSpacesTotal = 0;
    var _carSpacesAvailable = 0;
    var _motorBikeSpacesAvailable = 0 ;
    var _local = Localization() ;

    override init(){
        }
    
    var ParkingName:String{
        get{
            return _parkingName;
        }
        set{
            self._parkingName = newValue
        }
    }
    var OpeningTime:String{
        get{
            return _openingTime;
        }
        set{
            self._openingTime = newValue
        }
        
    }
    var ClosingTime:String{
        get{
            return _closingTime;
        }
        set{
            self._closingTime = newValue
        }
        
    }
    var Rate:Double{
        get{
            return _rate;
        }
        set{
            self._rate = newValue
        }
        
    }
    var CarSpacesTotal:Int{
        get{
            return _carSpacesTotal;
        }
        set{
            self._carSpacesTotal = newValue
        }
        
    }
    var CarSpacesAvailable:Int{
        get{
            return _carSpacesAvailable;
        }
        set{
            self._carSpacesAvailable = newValue
        }
        }
    var MotorBikeSpacesTotal:Int{
        get{
            return _motorBikeSpacesTotal;
        }
        set{
            self._motorBikeSpacesTotal = newValue
        }
        
    }
    var MotorBikeSpacesAvailable:Int{
        get{
            return _motorBikeSpacesAvailable;
        }
        set{
            self._motorBikeSpacesAvailable = newValue
        }
        
    }
    var Local:Localization{
        get{
            return _local;
        }
        set{
            self._local = newValue
        }
        
    
}



}