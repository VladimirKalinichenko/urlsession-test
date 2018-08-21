//
//  ViewController.swift
//  FacebookLoadingPics
//
//  Created by Vladimir Kalinichenko on 8/20/18.
//  Copyright © 2018 volody-home. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var session: Session!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        session = Session(subdomains: ["scontent"])
        let images = ["/v/t1.0-0/p180x540/39453250_1103193603178300_7117410156987547648_o.jpg?_nc_cat=0&oh=13b30e90239af2fd6344f6d217e84567&oe=5BFA0B54"]
        session.download(images: images)
        print(FileManager.default.temporaryDirectory)
    }
}

