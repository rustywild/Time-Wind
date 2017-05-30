//
//  ViewController.swift
//  MiTiempo
//
//  Created by rusty on 25/5/17.
//  Copyright © 2017 Javier Garcia. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    
    var button: UIButton!
    
    @IBOutlet weak var cityLabel: UITextField!
    
    @IBOutlet weak var preLabel: UILabel!
    
    @IBOutlet weak var windLabel: UILabel!
    

    
    
    @IBOutlet var loadingView: UIActivityIndicatorView!
    
 
    func buttonTapped() {
        guard let cityRaw = cityLabel.text else {
            
            self.preLabel.text = "No hay datos"
            
            return
        }
        
        let city = cityRaw.trimmingCharacters(in: .whitespacesAndNewlines)
        
        self.loadingView.startAnimating()


        WeatherManager.downloadWeather(from: city) { (result) in

            self.loadingView.stopAnimating()
            
            if let wind = result["wind"] as? [String: Any], let speed = wind["speed"]  {
                
                self.windLabel.text = String(describing: speed)
                print(speed)
                
            }
            
            if let weather = result["weather"] as? [[String:Any]] {
                
                for description in weather {
                    self.preLabel.text = description["description"] as? String
                }
                
            }
            
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cityLabel.placeholder = "Introduce ciudad"
        cityLabel.delegate = self
        setupButton ()

        
    }
    //para modificar el boton
    
    func setupButton () {
        button = UIButton.init(type: UIButtonType.system)
        
        button.setTitle("GO!!", for: UIControlState.normal)
        button.bounds = CGRect(x: 0, y: 0, width: 60, height: 30)
        button.center = CGPoint(x: 185, y: 240)
        button.backgroundColor = UIColor.lightGray
        button.setTitleColor(UIColor.white, for: UIControlState.normal)
        button.layer.masksToBounds = true
        
        button.addTarget(self, action: #selector(ViewController.buttonTapped), for: UIControlEvents.touchUpInside)
        button.layer.cornerRadius = 5
        
        
        
        view.addSubview(button)
        
    }
    
    
    
    
    
    
    
   
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool 
    {
        textField.resignFirstResponder()
        
        return true;
    }
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

}

