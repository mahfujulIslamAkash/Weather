//
//  UIController+Extension.swift
//  Weather
//
//  Created by Appnap Mahfuj on 19/3/24.
//

import UIKit

extension UIViewController{
    
    public func showAlertMessage(title: String, message: String, completion: @escaping(_ done: Bool)->Void){
        
        let alertMessagePopUpBox = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default, handler: {(action) in
            completion(true)
        })
        
        alertMessagePopUpBox.addAction(okButton)
        self.present(alertMessagePopUpBox, animated: true)
    }
    func showAlertForPermission(){
        showAlertMessage(title: AlertMessage.permission.title, message: AlertMessage.permission.description, completion: { (done) in
            if done{
                UIApplication.shared.open(URL(string: "App-prefs:LOCATION_SERVICES")!)
            }
        })
    }
    
    func showAlertForInternet(){
        showAlertMessage(title: AlertMessage.noInternet.title, message: AlertMessage.noInternet.description, completion: { [self](done) in
            
            if done{
                if !Connectivity.isConnectedToInternet{
                    showAlertForInternet()
                }
            }
        })
    }
    
}


