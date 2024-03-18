//
//  CGFloat+Extension.swift
//  Weather
//
//  Created by Appnap Mahfuj on 19/3/24.
//

import UIKit

extension CGFloat{
    init(w: CGFloat, for h: CGFloat = 0){
        if UIDevice.current.userInterfaceIdiom == .pad { //iPad 10.2 (8th Gen): 810 ╳ 1080
            if h > 0{
                self.init(.init(h: h) * w / h)
            }else{
                self.init(w / 810 * UIScreen.main.bounds.size.width)
            }
        }else{
            if h > 0{
                self.init(.init(h: h) * w / h)
            }else{
                self.init(w / 218 * UIScreen.main.bounds.size.width)
            }
        }
    }
    
    init(h: CGFloat, for w: CGFloat = 0){
        if UIDevice.current.userInterfaceIdiom == .pad { //iPad 10.2 (8th Gen): 810 ╳ 1080
            if w > 0{
                self.init(.init(w: w) * h / w)
            }else{
                self.init(h / 1080 * UIScreen.main.bounds.size.height)
            }
        }else{
            if w > 0{
                self.init(.init(w: w) * h / w)
            }else{
                self.init(h / 471 * UIScreen.main.bounds.size.height)
            }
        }
    }
}
