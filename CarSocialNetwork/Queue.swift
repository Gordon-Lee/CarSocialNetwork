//
//  Queue.swift
//  CarSocialNetwork
//
//  Created by Marco Aurelio Dias Americo on 8/18/16.
//  Copyright © 2016 CarSocial. All rights reserved.
//

import Foundation

protocol ExecutableQueue {
    var queue: dispatch_queue_t { get }
}

extension ExecutableQueue {
    func execute(block: dispatch_block_t) {
        dispatch_async(queue, block)
    }
}

enum Queue: ExecutableQueue {
    
    case Main
    case UserInteractive
    case UserInitiated
    case Utility
    case Background
    
    var queue: dispatch_queue_t {
        switch self {
        case .Main:
            return dispatch_get_main_queue()
            
        case .UserInteractive:
            return dispatch_get_global_queue(QOS_CLASS_USER_INTERACTIVE, 0)
            
        case .UserInitiated:
            return dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0)
            
        case .Utility:
            return dispatch_get_global_queue(QOS_CLASS_UTILITY, 0)
            
        case .Background:
            return dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0)
        }
    }
    
}

extension dispatch_queue_t {
    func delay(delay: Double, closure: ()->()) {
        dispatch_after(
            dispatch_time(DISPATCH_TIME_NOW, Int64(delay * Double(NSEC_PER_SEC))),
            self,
            closure
        )
    }
}