//
//  RandomUserTableViewCell.swift
//  RandomUser
//
//  Created by Mathis Detourbet on 30/12/19.
//  Copyright © 2019 Mathis Detourbet. All rights reserved.
//

import UIKit

class RandomUserTableViewCell: UITableViewCell {
    
    static let cellIdentifier = "idRandomUserTableViewCell"

    @IBOutlet private weak var firstNameLabel: UILabel!
    @IBOutlet private weak var lastNameLabel: UILabel!
    @IBOutlet private weak var emailLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func fill(with randomUser: RandomUser) {
        firstNameLabel.text = randomUser.name.first
        lastNameLabel.text = randomUser.name.last
        emailLabel.text = randomUser.email
    }
}
