//
//  ViewController.swift
//  AdkrossExample
//
//  Created by Furkan Kaplan on 14.07.2022.
//

import UIKit
import adkross_ios_sdk

class ViewController: UIViewController {
    private var adkross: AdkrossInterstitial!

    override func viewDidLoad() {
        super.viewDidLoad()
        adkross = AdkrossInterstitial(delegate: self)
        adkross.load()
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

