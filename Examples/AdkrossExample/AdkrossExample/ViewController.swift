//
//  ViewController.swift
//  AdkrossExample
//
//  Created by Furkan Kaplan on 14.07.2022.
//

import UIKit
import Adkross

class ViewController: UIViewController {
    @IBOutlet weak private var charachterLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak private var transparentView: UIView!
    @IBOutlet weak private var missionFailedLabel: UILabel!
    @IBOutlet weak private var keepContinueButton: UIButton!
    @IBOutlet weak private var startAgainButton: UIButton!

    private var adkross: AdkrossInterstitial!

    override func viewDidLoad() {
        super.viewDidLoad()
        adkross = AdkrossInterstitial(delegate: self)
        adkross.load()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        charachterLeadingConstraint.constant = 120

        UIView.animate(withDuration: 2) {
            self.view.layoutIfNeeded()
        } completion: { isCompleted in
            if isCompleted {
                self.transparentView.isHidden = false
                self.transparentView.isHidden = false
                self.missionFailedLabel.isHidden = false
                self.keepContinueButton.isHidden = false
                self.startAgainButton.isHidden = false
            }
        }
    }

    @IBAction func keepContinueButtonTapped(_ sender: Any) {
        self.adkross.present(fromRootViewController: self)
    }
}

extension ViewController: AdkrossInterstitialDelegate {
    func adkrossInterstitialAdFiredFailed(
        with message: String,
        evenType: EventType
    ) {
        print("adkrossInterstitialAdFiredFailed of \(evenType.rawValue) event with message: \(message)")
    }

    func adkrossInterstitialAdFired(with event: EventType) {
        print("\(event.rawValue) fired")
    }

    func adkrossInterstitial(failedWith message: String) {
        print("adkrossInterstitial(failedWith message: \(message)")
    }

    func adkrossInterstitialLoadedSuccessfully() {
        print("adkrossInterstitialLoadedSuccessfully")
    }

    func adkrossInterstitialAdPresented() {
        print("adkrossInterstitialAdPresented")
    }

    func adkrossInterstitialAdDismissed() {
        print("adkrossInterstitialAdDismissed")
    }

    func adkrossInterstitialAdTapped() {
        print("adkrossInterstitialAdDismissed")
    }
}

