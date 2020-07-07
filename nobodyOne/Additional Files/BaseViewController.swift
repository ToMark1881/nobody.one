//
//  BaseViewController.swift
//  nobodyOne
//
//  Created by Vladyslav Vdovychenko on 07.07.2020.
//  Copyright © 2020 Vladyslav Vdovychenko. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    var servicesContainer: ServicesContainer!

    override func viewDidLoad() {
        super.viewDidLoad()
        initServices()
    }
    
    func setNavigationTitle(_ title: String) {
        self.title = title
    }
    
    fileprivate func initServices() {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            servicesContainer = appDelegate.servicesContainer
        }
    }
    
    func handleError(_ err: Error?, text: String? = nil) {
        print(err?.localizedDescription ?? text ?? "Some Error")
    }

}
