//
//  ViewController.swift
//  Heropedia
//
//  Created by Tifo Audi Alif Putra on 12/02/21.
//

import UIKit

class HeroListViewController: UIViewController {

    var hero: [Hero] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        
        let service = DefaultNetworkService()
        service.fetchHero { (hero: [Hero]) in
            self.hero = hero
        } failure: { (error: ErrorResponse) in
            print(error)
        }
    }
}

