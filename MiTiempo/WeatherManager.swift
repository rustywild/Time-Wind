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
    
//    static public var result = [String : Any]()
    
//    public static func connect(from city: String)  {
//        let appID = "75cd27e565f7c340e550ae5dce2d27fd"
//        
//        Alamofire.request("http://api.openweathermap.org/data/2.5/weather?q=\(city)&APPID=\(appID)" + "&lang=es").responseJSON { response in
//            
//            guard let JSON = response.result.value else { return }
//            
//            result = JSON as! [String : Any]
//            
//        }
//    }
    
    // ----------------------------------------------
    
    // Misma función pero con closures
    
    // La función se define de forma normal, pero uno de los parámetros es un closure
    // En este caso, el closure sería (_ result: [String: Any]) -> ()
    // Para poder llamarlo desde dentro de la función, debemos hacer "completion(result)" por ejemplo
    public static func downloadWeather(from city: String, _ completion:@escaping (_ result: [String: Any]) -> ()) {
        
        let appID = "75cd27e565f7c340e550ae5dce2d27fd"
        let url = "http://api.openweathermap.org/data/2.5/weather?q=\(city)&APPID=\(appID)" + "&lang=es"
        
        // Descargamos los datos con alamofire
        Alamofire
            .request(url)
            .responseJSON { (response) in // Esta parte es un closure de Alamofire
            
                guard let JSON = response.result.value as? [String: Any] else {
                    completion([:]) // En este punto, el value no se puede convertir a Diccionario, llamamos al closure con un diccionario vacío
                    return // Hacemos un return porque sino seguiría la función
                }
                
                // Al pasar el "guard", tenemos un diccionario válido y lo podemos devolver vía el closure
                completion(JSON)
                
                // No es necesario hacer ningún return porque es el final de la función
                
        }
        
    }
    
    
}


