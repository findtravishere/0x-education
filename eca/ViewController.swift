//
//  ViewController.swift
//  eca
//
//  Created by travis on 24/8/22.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    // Subviews

    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var popularButton: UIButton!

    // Courses available
    var courses: [String] = ["Beginner iOS", "Advanced iOS", "Beginner Python", "Advanced Python", "Beginner Rust", "Advanced Rust", "Beginner Typescript", "Advanced Typescript", "React", "Vue", "Angular", "Svelte", "Node", "Beginner Algorithms", "Advanced Algorithms", "Beginner Go", "Advanced Go", "Git", "Docker", "Kubernetes"]

    // Searched courses
    var filteredCourses: [String]!
    var filteredPopularCourses: [String]!

    // Popular courses
    var popularCourses: [String] = ["Tom"]
    var popularState: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
        filteredCourses = courses
        filteredPopularCourses = popularCourses
        let viewGesture = UITapGestureRecognizer(target: self, action: #selector(handlePopularClick))
        popularButton.addGestureRecognizer(viewGesture)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !popularState {
            return filteredCourses.count
        } else {
            return filteredPopularCourses.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if !popularState {
            let cell = UITableViewCell()
            cell.textLabel?.text = filteredCourses[indexPath.row]
            return cell
        } else {
            let cell = UITableViewCell()
            cell.textLabel?.text = filteredPopularCourses[indexPath.row]
            return cell
        }
    }

    // Popular Button Handler
    @objc func handlePopularClick() {
        if popularState {
            popularState = !popularState
            popularButton.setTitle("Popular Courses", for: .normal)
        } else {
            popularState = !popularState
            popularButton.setTitle("All Courses", for: .normal)
        }
        tableView.reloadData()
    }

    // Search Bar Config
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredCourses = []
        filteredPopularCourses = []

        switch popularState {
            case false:
                if searchText == "" {
                    filteredCourses = courses
                } else {
                    for course in courses {
                        if course.lowercased().contains(searchText.lowercased()) {
                            filteredCourses.append(course)
                        }
                    }
                }
            case true:
                if searchText == "" {
                    filteredPopularCourses = popularCourses
                } else {
                    for course in popularCourses {
                        if course.lowercased().contains(searchText.lowercased()) {
                            filteredPopularCourses.append(course)
                        }
                    }
                }
        }

        tableView.reloadData()
    }
}
