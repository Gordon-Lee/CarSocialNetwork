//
//  Car.swift
//  CarSocialNetwork
//
//  Created by Marco Aurelio Dias Americo on 8/31/16.
//  Copyright © 2016 CarSocial. All rights reserved.
//

import Parse

class Car: PFObject, PFSubclassing {
    
    @NSManaged var owner: PFUser
    @NSManaged var brand: String
    @NSManaged var model: String
    @NSManaged var year: Int
    @NSManaged var image: PFFile
    @NSManaged var thumbImage: PFFile
    
    fileprivate var imageUI: UIImage!
    
    override init() { super.init() }
    
    init(brand: String, model: String, year: Int){
        super.init()
        self.brand = brand
        self.model = model
        self.year = year
    }
    
    static func parseClassName() -> String {
        return "Car"
    }
    
    func fileToImage() -> UIImage {
        self.image.getDataInBackground { (file, error) in
            if let image = UIImage(data: file!) {
                self.imageUI = image
            }
        }
        return imageUI
    }
}
