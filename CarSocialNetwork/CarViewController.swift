//
//  CarViewController.swift
//  CarSocialNetwork
//
//  Created by Marco Aurelio on 15/10/16.
//  Copyright © 2016 CarSocial. All rights reserved.
//

import UIKit
import Fusuma
import Parse

enum howView {
    case save, inicial
}

class CarViewController: UIViewController {
    
    static let identifier = "Car"

    fileprivate weak var brandSelection: BrandSelectionView!
    fileprivate weak var finishedRegister: FinishedCarRegisterView!
    fileprivate var subviewsFrame: CGRect!
    fileprivate var carToSave = Car()
    fileprivate var viewTo: howView = .inicial
    
    fileprivate var fus = FusumaViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        fus.delegate = self
        FusumaConfig.defaultCfg()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        title = "Registro Carro"
        
        switch viewTo {
        case .inicial:
            calculateSubFrame()
            inicialRegister()
        case .save:
            calculateSubFrame()
        }
    }
    
    fileprivate func configView() {
        UIApplication.shared.statusBarStyle = .default
        view.backgroundColor = AppCongifuration.lightGrey()
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.topItem?.leftBarButtonItem?.tintColor = AppCongifuration.blue()
    }
    fileprivate func calculateSubFrame() {
        let viewFrame = view.frame
        let viewOrigin = viewFrame.origin
        let navBarHeight = navigationController?.navigationBar.frame.height
        let newY = viewOrigin.y + navBarHeight!
        let newHeight = viewFrame.height - navBarHeight!
        subviewsFrame = CGRect(x: viewOrigin.x, y: newY, width: viewFrame.width, height: newHeight)
    }
    
    fileprivate func inicialRegister() {
        let nib = Bundle.main.loadNibNamed(BrandSelectionView.nibName, owner: self, options: nil)
        brandSelection = nib!.first as! BrandSelectionView
        brandSelection.delegate = self
        brandSelection.frame = subviewsFrame
        viewTo = .save
        view.addSubview(brandSelection)
    }
    
    fileprivate func showFusuma() {
        present(fus, animated: true, completion: nil)
    }
    
    fileprivate func loadFinishedRegister() {
        let nib = Bundle.main.loadNibNamed(FinishedCarRegisterView.nibName, owner: self, options: nil)
        finishedRegister = nib!.first as! FinishedCarRegisterView
        finishedRegister.delegate = self
        finishedRegister.car = carToSave
        finishedRegister.frame = subviewsFrame
        view.addSubview(finishedRegister)
    }
}

extension CarViewController : FusumaDelegate {
    
    func fusumaImageSelected(_ image: UIImage) {
        print("IMAGE SELECTED CAR")
    }
    
    func fusumaDismissedWithImage(_ image: UIImage) {
        print("Called just after FusumaViewController is dismissed.")
        
        carToSave.owner = PFUser.current()!
        //carToSave.imageUI = image
        carToSave.thumbImage = PFFile(data: AdjustPhoto.uploadToPhoto(image, type: .thumb))!
        carToSave.image = PFFile(data: AdjustPhoto.uploadToPhoto(image, type: .normal))!
        loadFinishedRegister()
    }
    
    func fusumaVideoCompleted(withFileURL fileURL: URL) {
        print("Called just after a video has been selected.")
    }
    
    func fusumaCameraRollUnauthorized() {
        print("Camera roll unauthorized")
    }
}

extension CarViewController: BrandSelectionDelegate {
    func didTapSelectionPhoto(car: Car) {
        viewTo = .save
        carToSave = car
        showFusuma()
    }
}

extension CarViewController: FinishedCarDelegate {
    func didFinishedCarRegister() {
        carToSave.saveInBackground()
        navigationController?.popViewController(animated: true)
    }
}
