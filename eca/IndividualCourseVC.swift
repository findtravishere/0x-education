//
//  IndividualCourseVC.swift
//  eca
//
//  Created by travis on 25/8/22.
//

import UIKit

class IndividualCourseVC: UIViewController {
    @IBOutlet var textView: UITextView!
    var courseTitle = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .dark
        title = courseTitle
        textView.text = courseTitle
    }
}
