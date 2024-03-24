//
//  ObservableObject.swift
//  Weather
//
//  Created by Appnap Mahfuj on 24/3/24.
//

import Foundation

final class ObservableObject<T>{
    var value: T{
        didSet{
            listener?(value)
        }
    }
    private var listener: ((T)->Void)?
    init(_ value: T){
        self.value = value
    }
    
    func binds(_ listener: @escaping(T)-> Void){
        listener(value)
        self.listener = listener
        
    }
}
