//
//  ReviewVC.swift
//  eca
//
//  Created by travis on 25/8/22.
//

import CoreData
import UIKit

class ReviewVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var tableView: UITableView!
    @IBOutlet var reviewField: UITextView!
    @IBOutlet var userField: UITextField!

    var courseTitle = ""
    var review = ""
    var reviews = [String: [String: String]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        title = courseTitle
        getData()
    }

    override func viewDidAppear(_ animated: Bool) {}

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var cnt = 0
        if reviews.keys.contains(title!) {
            cnt = reviews[title!]!.count
        }
        return cnt
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        review = "test ascjkasha aksjchkajsc jkhasjkchasc jkhasjkasc jkahsckjahs jkashcjkashjkc jkashckjahsas jkashcjahscjkahsjkca jkahsjkcajkschajkscka jkahsckjahscjkhasjkcjkajksc jkahscjkahsjckhajkschsjk bnasmcbamnsbnmasc jkahscjkahscjashckja jkahscjkahjkschascjkash ajkschajkhscjas"
        cell.textLabel?.text = review
        let viewGesture = UITapGestureRecognizer(target: self, action: #selector(handleReview))
        cell.addGestureRecognizer(viewGesture)
        return cell
    }

    // Submit button to send reviews into coredata and refresh reviews upon submission
    @IBAction func submitButton(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        // container where core data saveed in
        let context = appDelegate.persistentContainer.viewContext

        let newReview = NSEntityDescription.insertNewObject(forEntityName: "Review", into: context)

        // Attributes
        newReview.setValue(reviewField.text, forKey: "review")
        newReview.setValue(title, forKey: "course")
        newReview.setValue(userField.text, forKey: "user")

        NotificationCenter.default.post(name: NSNotification.Name("newData"), object: nil)
        getData()
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

                            // one user can only submit one review for each course, will be modified on subsequent submission
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

    // TODO: either add popup or new vc
    @objc func handleReview() {
        print(review)
    }
}
