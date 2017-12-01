//
//  ViewController.swift
//  SingleScreenRxSwiftApp
//
//  Created by Alper Akinci on 01/12/2017.
//  Copyright © 2017 Alper Akinci. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!

    var imageVariable = Variable<UIImage?>(#imageLiteral(resourceName: "rxswift_icon"))
    let disposeBag = DisposeBag()

    var clearButton: UIBarButtonItem? {
        set {
            self.navigationItem.leftBarButtonItem = newValue
        }
        get {
            return self.navigationItem.leftBarButtonItem
        }
    }

    var addButton: UIBarButtonItem? {
        set {
            self.navigationItem.rightBarButtonItem = newValue
        }
        get {
            return self.navigationItem.rightBarButtonItem
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Test"

        clearButton = UIBarButtonItem(title: "Clear",
                                      style: .plain,
                                      target: self,
                                      action: #selector(clearImage)
        )

        addButton =  UIBarButtonItem(barButtonSystemItem: .add,
                        target: self,
                        action: #selector(addImage)
        )


        imageVariable.asObservable().subscribe(onNext: {[weak self] (image) in
            self?.imageView.image = image
        }).disposed(by: disposeBag)

        imageVariable.asObservable().subscribe(onNext: {[weak self] (image) in
            self?.updateUI(image: image)
        }).disposed(by: disposeBag)

    }

    func updateUI(image: UIImage?) {
        // set image name to title
        self.navigationItem.title = image == nil ? "Pick image" : "Image Added"
        // if there is image, enable clear image button
        clearButton?.isEnabled = image != nil
    }

    @objc func clearImage() {
        imageVariable.value = nil
    }

    @objc func addImage(){
        imageVariable.value = #imageLiteral(resourceName: "rxswift_icon")
    }

}

