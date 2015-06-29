//
//  Localization.swift
//  webApi3
//
//  Created by internet on 5/21/15.
//  Copyright (c) 2015 internet. All rights reserved.
//

import UIKit

class Localization: NSObject {
    
    var  _latitude = 0.0;
    var  _longitude = 0.0;


    var Latitude:Double{
        get{
            return _latitude;
        }
        set{
            self._latitude = newValue
            }
        }
    var Longitude:Double{
        get{
          return _longitude;
        }
        set{
            self._longitude = newValue
        }
   }
}

