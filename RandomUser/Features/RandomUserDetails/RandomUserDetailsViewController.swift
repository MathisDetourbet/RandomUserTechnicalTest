//
//  RandomUserDetailsViewController.swift
//  RandomUser
//
//  Created by Mathis Detourbet on 30/12/19.
//  Copyright © 2019 Mathis Detourbet. All rights reserved.
//

import UIKit
import Kingfisher

final class RandomUserDetailsViewController: UIViewController {
    
    @IBOutlet private weak var pictureImageView: UIImageView!
    @IBOutlet private weak var firstNameLabel: UILabel!
    @IBOutlet private weak var lastNameLabel: UILabel!
    
    private var randomUser: RandomUser!
    
    static func instantiate(with randomUser: RandomUser) -> RandomUserDetailsViewController {
        let viewController = RandomUserDetailsViewController()
        viewController.randomUser = randomUser
        return viewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        buildUI()
    }
    
    private func buildUI() {
        firstNameLabel.text = randomUser.name.first
        lastNameLabel.text = randomUser.name.last
        
        if let largePictureUrl = randomUser.picture.large {
            pictureImageView.kf.setImage(with: largePictureUrl)
        }
    }
}
