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
    var courses: [String] = ["Beginner iOS", "Advanced iOS", "Beginner Python", "Advanced Python", "Beginner Rust", "Advanced Rust", "Beginner Typescript", "Advanced Typescript", "React", "Vue", "Angular", "Svelte", "Deno", "Beginner Algorithms", "Advanced Algorithms", "Beginner Go", "Advanced Go", "Git", "Docker", "Kubernetes"]

    // Searched courses
    var filteredCourses: [String]!
    var filteredPopularCourses: [String]!

    // Popular courses
    var popularCourses: [String] = ["Beginner Python", "Advanced iOS", "React", "Git"]
    var popularState: Bool = false

    // Individual course
    var selectedCourse = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .dark
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
        filteredCourses = courses
        filteredPopularCourses = popularCourses
        let viewGesture = UITapGestureRecognizer(target: self, action: #selector(handlePopularClick))
        popularButton.addGestureRecognizer(viewGesture)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
        filteredCourses = courses
        filteredPopularCourses = popularCourses
        let viewGesture = UITapGestureRecognizer(target: self, action: #selector(handlePopularClick))
        popularButton.addGestureRecognizer(viewGesture)
        navigationController?.setNavigationBarHidden(true, animated: animated)
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
            cell.textLabel?.font = UIFont.systemFont(ofSize: 22.0)
            cell.textLabel?.font = UIFont(name: "Copperplate", size: 22.0)
            return cell
        } else {
            let cell = UITableViewCell()
            cell.textLabel?.text = filteredPopularCourses[indexPath.row]
            cell.textLabel?.font = UIFont(name: "Copperplate", size: 22.0)
            return cell
        }
    }

    // Move to individual course screen

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCourseVC" {
            let destinationVC = segue.destination as! CourseVC
            destinationVC.chosenCourse = selectedCourse
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !popularState {
            selectedCourse = filteredCourses[indexPath.row]
        } else {
            selectedCourse = filteredPopularCourses[indexPath.row]
        }

        performSegue(withIdentifier: "toCourseVC", sender: nil)
    }

    // Popular Button Handler
    @objc func handlePopularClick() {
        if popularState {
            popularState = !popularState
            popularButton.setTitle("🔥 View Popular Courses", for: .normal)
            popularButton.tintColor = .systemRed
            print(popularState)
        } else {
            popularState = !popularState
            popularButton.setTitle("🧑🏼‍💻 View All Courses", for: .normal)
            popularButton.tintColor = .systemBlue
            print(popularState)
        }
        tableView.reloadData()
    }

    // Search Bar Config
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredCourses = []
        filteredPopularCourses = []

        switch popularState {
            case false:
                if searchText.count == 0 {
                    filteredCourses = courses
                    filteredPopularCourses = popularCourses
                } else {
                    for course in courses {
                        if course.lowercased().contains(searchText.lowercased()) {
                            filteredCourses.append(course)
                        }
                    }
                    for course in popularCourses {
                        if course.lowercased().contains(searchText.lowercased()) {
                            filteredPopularCourses.append(course)
                        }
                    }
                }
            case true:
                if searchText.count == 0 {
                    filteredPopularCourses = popularCourses
                    filteredCourses = courses
                } else {
                    for course in popularCourses {
                        if course.lowercased().contains(searchText.lowercased()) {
                            filteredPopularCourses.append(course)
                        }
                    }
                    for course in courses {
                        if course.lowercased().contains(searchText.lowercased()) {
                            filteredCourses.append(course)
                        }
                    }
                }
        }

        tableView.reloadData()
    }
}
