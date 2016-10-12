//
//  Queue.swift
//  CarSocialNetwork
//
//  Created by Marco Aurelio Dias Americo on 8/18/16.
//  Copyright © 2016 CarSocial. All rights reserved.
//

import Foundation

protocol ExecutableQueue {
    var queue: DispatchQueue { get }
}

extension ExecutableQueue {
    func execute(_ block: @escaping ()->()) {
        queue.async(execute: block)
    }
}

enum Queue: ExecutableQueue {
    
    case main
    case userInteractive
    case userInitiated
    case utility
    case background
    
    var queue: DispatchQueue {
        switch self {
        case .main:
            return DispatchQueue.main
            
        case .userInteractive:
            return DispatchQueue.global(qos: DispatchQoS.QoSClass.userInteractive)
            
        case .userInitiated:
            return DispatchQueue.global(qos: DispatchQoS.QoSClass.userInitiated)
            
        case .utility:
            return DispatchQueue.global(qos: DispatchQoS.QoSClass.utility)
            
        case .background:
            return DispatchQueue.global(qos: DispatchQoS.QoSClass.background)
        }
    }
    
}

extension DispatchQueue {
    func delay(_ delay: Double, closure: @escaping ()->()) {
        self.asyncAfter(
            deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC),
            execute: closure
        )
    }
}
