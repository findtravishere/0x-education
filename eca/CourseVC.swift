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

    var chosenCourse = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        title = chosenCourse + " Overview"
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
