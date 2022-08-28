//
//  ReviewVC.swift
//  eca
//
//  Created by travis on 25/8/22.
//

import CoreData
import UIKit

class ReviewVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextViewDelegate {
    @IBOutlet var tableView: UITableView!
    @IBOutlet var reviewField: UITextView!
    @IBOutlet var userField: UITextField!
    @IBOutlet var submitButton2: UIButton!
    @IBOutlet var usernameError: UILabel!

    var courseTitle = ""
    var review = ""
    var reviews = [String: [String: String]]()
    var shownReview = ""

    var displayedReview: [String] = []
    var reviewUser: [String] = []
    var userState = false
    var reviewState = false

    var selectedUser = ""
    var selectedReview = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .dark
        tableView.dataSource = self
        tableView.delegate = self
        reviewField.delegate = self
        title = courseTitle

        resetFields()
        userCheck(userField!)
        checkReviewFields()
        getData()

        // Customize button
        submitButton2.backgroundColor = .clear
        submitButton2.layer.cornerRadius = 10
        submitButton2.layer.borderWidth = 1
        submitButton2.layer.borderColor = UIColor.systemGray.cgColor
    }

    override func viewDidAppear(_ animated: Bool) {
        resetFields()
        userCheck(userField!)
        checkReviewFields()
    }

    @objc func hideKeyboard() {
        view.endEditing(true)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var cnt = 0
        if reviews.keys.contains(title!) {
            cnt = reviews[title!]!.count
        }
        return cnt
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        if reviews.keys.contains(title!) {
            for i in reviews[title!]! {
                if !reviewUser.contains(i.0) {
                    displayedReview.append(i.1)
                    reviewUser.append(i.0)
                }
            }
        }
        shownReview = displayedReview[indexPath.row]
        if shownReview.count > 25 {
            cell.textLabel?.text = "\(String(displayedReview[indexPath.row].prefix(25))) ... [read more]"
        } else {
            cell.textLabel?.text = displayedReview[indexPath.row]
        }

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedUser = reviewUser[indexPath.row]
        selectedReview = displayedReview[indexPath.row]
        performSegue(withIdentifier: "toIndividualReviewVC", sender: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toIndividualReviewVC" {
            let destinationVC = segue.destination as! IndividualReviewVC
            destinationVC.username = selectedUser
            destinationVC.reviewContent = selectedReview
            destinationVC.courseTitle = courseTitle
        }
    }

    // Submit button to send reviews into coredata and refresh reviews upon submission
    @IBAction func submitButton(_ sender: Any) {
        userCheck(userField!)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        // container where core data saved in
        let context = appDelegate.persistentContainer.viewContext

        let newReview = NSEntityDescription.insertNewObject(forEntityName: "Review", into: context)

        // Attributes

        newReview.setValue(reviewField.text, forKey: "review")
        newReview.setValue(title, forKey: "course")
        newReview.setValue(userField.text, forKey: "user")

        NotificationCenter.default.post(name: NSNotification.Name("newData"), object: nil)
        do {
            try context.save()
        } catch {
            print("An error occured while saving")
        }

        getData()
        resetFields()
        // return to menu
//        navigationController?.popViewController(animated: true)
    }

    // Fetch the data from coredata sqlite db for mock persistent storage since Firebase is not required
    @objc func getData() {
        reviews.removeAll(keepingCapacity: false)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Review")
        fetchRequest.returnsObjectsAsFaults = false

        do {
            let results = try context.fetch(fetchRequest) // returned as array
            if results.count > 0 {
                for result in results as! [NSManagedObject] {
                    if let course = result.value(forKey: "course") as? String {
                        if reviews[course] == nil {
                            reviews[course] = [:]
                        }
                        if let user = result.value(forKey: "user") as? String {
                            if reviews[course]?[user] == nil {
                                reviews[course]?[user] = ""
                            }

                            // one user can only submit one review for each course
                            if let review = result.value(forKey: "review") as? String {
                                reviews[course]?[user] = review
                            }
                        }
                    }
                    tableView.reloadData()
                }
            }
        } catch {
            print("error")
        }
    }

    // Checks for username field and reviews
    @IBAction func userCheck(_ sender: Any) {
        if let _ = userField.text, userField.text?.count != 0 {
            if reviewState, !reviewUser.contains(userField.text!) {
                userState = true
                submitButton2.layer.borderColor = UIColor.blue.cgColor
                submitButton2.isEnabled = true
                usernameError.isHidden = true

            } else if reviewUser.contains(userField.text!) {
                submitButton2.isEnabled = false
                usernameError.isHidden = false
                submitButton2.layer.borderColor = UIColor.systemGray.cgColor
                userState = false
            } else if !userState || !reviewState {
                submitButton2.isEnabled = false
                usernameError.isHidden = true
                submitButton2.layer.borderColor = UIColor.systemGray.cgColor
            }

        } else {
            userState = false
            if !reviewState || !userState {
                submitButton2.isEnabled = false
                submitButton2.layer.borderColor = UIColor.systemGray.cgColor
            }
        }
    }

    // monitor whether reviews are empty
    func textViewDidChange(_ textView: UITextView) {
        checkReviewFields()
        userCheck(userField!)
    }

    private func checkReviewFields() {
        if let _ = reviewField.text, reviewField.text?.count != 0 {
            reviewState = true
            if reviewState, userState {
                submitButton2.isEnabled = true
                submitButton2.layer.borderColor = UIColor.blue.cgColor
            }
        } else {
            reviewState = false
            if !reviewState || !userState {
                submitButton2.isEnabled = false
                submitButton2.layer.borderColor = UIColor.systemGray.cgColor
            }
        }
    }

    // Reset all modifiers after submitting
    private func resetFields() {
        userField.text = ""
        reviewField.text = ""
        submitButton2.isEnabled = false
        userState = false
        reviewState = false
        usernameError.isHidden = true
        submitButton2.layer.borderColor = UIColor.systemGray.cgColor
        view.endEditing(true)
    }
}
