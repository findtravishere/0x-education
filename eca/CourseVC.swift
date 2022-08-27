//
//  CourseVC.swift
//  eca
//
//  Created by travis on 25/8/22.
//

import UIKit

class CourseVC: UIViewController, UINavigationControllerDelegate {
    @IBOutlet var startCourseButton: UIButton!
    @IBOutlet var reviewsButton: UIButton!
    @IBOutlet var courseLabel: UILabel!

    var chosenCourse = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .dark
        let colorBottom = UIColor(red: 1, green: 0.9412, blue: 0.7098, alpha: 1.0).cgColor
        let colorTop = UIColor(red: 0.6314, green: 0.4392, blue: 0.6471, alpha: 1.0).cgColor
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [colorTop, colorBottom]
        view.layer.insertSublayer(gradientLayer, at: 0)

        startCourseButton.backgroundColor = .clear
        startCourseButton.layer.cornerRadius = 10
        startCourseButton.layer.borderWidth = 1
        startCourseButton.layer.borderColor = UIColor.black.cgColor
        startCourseButton.titleLabel?.font = UIFont(name: "GillSans-Bold", size: 30)
        reviewsButton.backgroundColor = .clear
        reviewsButton.layer.cornerRadius = 20
        reviewsButton.layer.borderWidth = 1
        reviewsButton.layer.borderColor = UIColor.black.cgColor
        reviewsButton.titleLabel?.font = UIFont(name: "GillSans-Bold", size: 30)
        courseLabel.text = chosenCourse
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toIndividualCourseVC" {
            let destinationVC = segue.destination as! IndividualCourseVC
            destinationVC.courseTitle = chosenCourse
        }
        if segue.identifier == "toReviewVC" {
            let destinationVC = segue.destination as! ReviewVC
            destinationVC.courseTitle = chosenCourse
        }
    }
}
