//
//  ReviewVC.swift
//  eca
//
//  Created by travis on 25/8/22.
//

import UIKit

class ReviewVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var tableView: UITableView!
    @IBOutlet var submitButton: UIButton!
    var courseTitle = ""
    var review = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        title = courseTitle
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
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

    // TODO: either add popup or new vc
    @objc func handleReview() {
        print(review)
    }
}
