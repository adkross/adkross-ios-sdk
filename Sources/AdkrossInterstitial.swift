//
//  AdkrossInterstitial.swift
//
//
//  Created by Furkan Kaplan on 9.07.2022.
//

import UIKit

public protocol AdkrossInterstitialDelegate: AnyObject {
    func adkrossInterstitial(failedWith message: String)
    func adkrossInterstitialLoadedSuccessfully()
    func adkrossInterstitialAdPresented()
    func adkrossInterstitialAdDismissed()
    func adkrossInterstitialAdTapped()
    func adkrossInterstitialAdFired(with event: EventType)
    func adkrossInterstitialAdFiredFailed(with message: String, evenType: EventType)
}

public extension AdkrossInterstitialDelegate {
    func adkrossInterstitial(failedWith message: String) { }
    func adkrossInterstitialLoadedSuccessfully() { }
    func adkrossInterstitialAdPresented() { }
    func adkrossInterstitialAdDismissed() { }
    func adkrossInterstitialAdTapped() { }
    func adkrossInterstitialAdFired(with event: EventType) { }
    func adkrossInterstitialAdFiredFailed(with message: String, evenType: EventType) { }
}

public class AdkrossInterstitial {
    private unowned let delegate: AdkrossInterstitialDelegate
    private let adkrossInstance: Adkross
    private var instertitialAd: CampaignLoad.Response?
    
    public init(
        delegate: AdkrossInterstitialDelegate,
        adkrossInstance: Adkross = Adkross.shared
    ) {
        self.delegate = delegate
        self.adkrossInstance = adkrossInstance
    }
    
    public var isInterstitialLoaded: Bool {
        instertitialAd != nil
    }
 
    public func load(
        campaignKey: String? = nil
    ) {
        adkrossInstance.load(
            campaignKey: campaignKey
        ) { [weak self] response in
            guard let self = self else {
                return
            }

            switch response {
            case .success(let model):
                self.instertitialAd = model
                self.delegate.adkrossInterstitialLoadedSuccessfully()
                self.fireEvent(with: .LOAD)
            case .failure(let message):
                self.delegate.adkrossInterstitial(
                    failedWith: message
                )
            }
        }
    }
    
    public func present(
        fromRootViewController containerViewController: UIViewController
    ) {
        guard let ad = instertitialAd else {
            return
        }

        let instertitialAdViewController = AdkrossInterstitialViewController(
            adkrossInstance: adkrossInstance,
            ad: ad,
            delegate: self
        )
        instertitialAdViewController.modalPresentationStyle = .overFullScreen

        containerViewController.present(
            instertitialAdViewController,
            animated: true
        ) {
            self.delegate.adkrossInterstitialAdPresented()
            self.fireEvent(with: .DISPLAY)
        }
    }
}

extension AdkrossInterstitial: AdkrossInterstitialViewControllerDelegate {

    func adkrossInterstitialViewControllerDissmised() {
        delegate.adkrossInterstitialAdDismissed()
    }
    
    func adkrossInterstitialViewControllerTapped() {
        delegate.adkrossInterstitialAdTapped()
    }

    func adkrossInterstitialAdFired(
        with event: EventType
    ) {
        delegate.adkrossInterstitialAdFired(with: event)
    }

    func adkrossInterstitialAdFiredFailed(
        with message: String,
        evenType: EventType
    ) {
        delegate.adkrossInterstitialAdFiredFailed(
            with: message,
            evenType: evenType
        )
    }
}

// MARK: - Network Call

extension AdkrossInterstitial {

    func fireEvent(
        with event: EventType
    ) {
        guard let instertitialAd else {
            return
        }

        adkrossInstance.fireEvent(
            campaignKey: instertitialAd.campaign?.id ?? "",
            analyticEventType: event
        ) { [weak self] result in
            guard let self else {
                return
            }

            switch result {
            case .success:
                self.delegate.adkrossInterstitialAdFired(
                    with: event
                )
            case .failure(let message):
                self.delegate.adkrossInterstitialAdFiredFailed(
                    with: message,
                    evenType: event
                )
            }
        }
    }
}
