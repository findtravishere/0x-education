//
//  IndividualCourseVC.swift
//  eca
//
//  Created by travis on 25/8/22.
//

import AVFoundation
import AVKit
import UIKit

class IndividualCourseVC: UIViewController {
    @IBOutlet var playButton: UIImageView!
    @IBOutlet var textView: UITextView!

    var courseTitle = ""
    let playerController = AVPlayerViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .dark
        title = courseTitle
        textView.text = courseTitle
        playButton.image = UIImage(named: courseTitle)

        // Set gesture for playing button
        let viewGesture = UITapGestureRecognizer(target: self, action: #selector(playVideo))
        playButton.isUserInteractionEnabled = true
        playButton.addGestureRecognizer(viewGesture)
    }

    // Play video according to what course user selected
    @objc func playVideo() {
        let player = AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: courseTitle, ofType: "mp4")!))
        NotificationCenter.default.addObserver(self, selector: #selector(playerDidFinishPlaying), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: playerController.player?.currentItem)
        playerController.player = player
        present(playerController, animated: true) {
            player.play()
        }
    }

    // Dismiss video when closed and return to view
    @objc func playerDidFinishPlaying(note: NSNotification) {
        playerController.dismiss(animated: true, completion: nil)
    }
}
