//
//  Reachability+Extension.swift
//  Weather
//
//  Created by Appnap Mahfuj on 19/3/24.
//

import UIKit
import Foundation
import Alamofire


class Connectivity {
    
    class var isConnectedToInternet:Bool {
        return NetworkReachabilityManager()!.isReachable
    }

}

