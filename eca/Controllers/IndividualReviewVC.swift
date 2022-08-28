//
//  IndividualReviewVC.swift
//  eca
//
//  Created by travis on 27/8/22.
//

import UIKit

class IndividualReviewVC: UIViewController {
    @IBOutlet var usernameLabel: UILabel!
    @IBOutlet var reviewText: UITextView!

    var reviewContent = ""
    var username = ""
    var courseTitle = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .dark
        usernameLabel.text = "\(username)'s review for \(courseTitle)"
        reviewText.text = reviewContent

        // Customize button
        usernameLabel.layer.cornerRadius = 5
        usernameLabel.layer.borderWidth = 1
        usernameLabel.layer.borderColor = UIColor.systemMint.cgColor
        usernameLabel.lineBreakMode = .byWordWrapping
        usernameLabel.numberOfLines = 5
    }
}
