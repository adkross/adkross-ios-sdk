//
//  AdkrossInterstitial.swift
//
//
//  Created by Furkan Kaplan on 9.07.2022.
//

import UIKit

public protocol AdkrossInterstitialDelegate: AnyObject {
    func adkrossInterstitial(
        failedWith message: String
    )
    func adkrossInterstitialLoadedSuccessfully()
    func adkrossInterstitialAdPresented()
    func adkrossInterstitialAdDismissed()
    func adkrossInterstitialAdTapped()
}
public class AdkrossInterstitial {
    private unowned let delegate: AdkrossInterstitialDelegate
    private let adkrossInstance: Adkross
    private var instertitialAd: CampaignLoadModel.Response?
    
    public init(
        delegate: AdkrossInterstitialDelegate,
        adkrossInstance: Adkross = Adkross.shared
    ) {
        self.delegate = delegate
        self.adkrossInstance = adkrossInstance
    }
    
    var isInterstitialLoaded: Bool {
        instertitialAd != nil
    }
 
    public func load(
        campaignId: String? = nil
    ) {
        adkrossInstance.load(
            campaignId: campaignId
        ) { [weak self] response in
            guard let strongSelf = self else { return }
        
            if let error = response.error {
                guard let message = error.message else { return }
                
                strongSelf.delegate.adkrossInterstitial(failedWith: message)
                return
            }
            
            guard let responseData = response.data else { return }
            
            strongSelf.instertitialAd = responseData
            
            strongSelf.delegate.adkrossInterstitialLoadedSuccessfully()
        }
    }
    
    public func present(
        fromRootViewController containerViewController: UIViewController
    ) {
        guard let ad = instertitialAd else { return }
        
        let instertitialAdViewController = AdkrossInterstitialViewController(
            adkrossInstance: adkrossInstance,
            ad: ad,
            delegate: self
        )
        instertitialAdViewController.modalPresentationStyle = .overFullScreen
        instertitialAdViewController.modalTransitionStyle = .crossDissolve
        
        containerViewController.present(
            instertitialAdViewController,
            animated: true
        ) {
            self.delegate.adkrossInterstitialAdPresented()
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
}
