//
//  FinishedCarRegisterView.swift
//  CarSocialNetwork
//
//  Created by Marco Aurelio on 15/10/16.
//  Copyright © 2016 CarSocial. All rights reserved.
//

import UIKit

protocol FinishedCarDelegate: class {
    func didFinishedCarRegister()
}

class FinishedCarRegisterView: UIView {
    
    static let nibName = "FinishedCarRegister"

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var model: UILabel!
    @IBOutlet weak var marca: UILabel!
    @IBOutlet weak var year: UILabel!
    
    weak var delegate: FinishedCarDelegate!
    
    var car = Car() {
        didSet {
            load()
            backgroundColor = AppCongifuration.lightGrey()
        }
    }

    fileprivate func load() {
        model.text = car.model
        marca.text = car.brand
        year.text = String(car.year)
        
        car.image.getDataInBackground { (data, error) in
            if let image = UIImage(data: data!) {
                self.image.image = image
            }
        }
    }
    
    @IBAction func save(_ sender: AnyObject) {
        delegate?.didFinishedCarRegister()
    }
}
