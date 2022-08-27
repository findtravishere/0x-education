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
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameLabel.text = username
        reviewText.text = reviewContent
    }
}
