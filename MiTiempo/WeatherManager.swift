//
//  WeatherManager.swift
//  MiTiempo
//
//  Created by rusty on 25/5/17.
//  Copyright © 2017 Javier Garcia. All rights reserved.
//

import Foundation
import Alamofire


class WeatherManager {
    

    public static func downloadWeather(from city: String, _ completion:@escaping (_ result: [String: Any]) -> ()) {
        
        let appID = "yourApiKey"
        let url = "http://api.openweathermap.org/data/2.5/weather?q=\(city)&APPID=\(appID)" + "&lang=es"
        
       
        Alamofire
            .request(url)
            .responseJSON { (response) in
                guard let JSON = response.result.value as? [String: Any] else {
                    completion([:])
                    return
                }
                
               
                completion(JSON)
                
                
                
        }
        
    }
    
    
}


