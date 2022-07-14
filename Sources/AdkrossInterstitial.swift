//
//  AdkrossInterstitial.swift
//
//
//  Created by Furkan Kaplan on 9.07.2022.
//

import Foundation

public protocol AdkrossInterstitialDelegate: AnyObject {
    func adkrossInterstitial(failedWith message: String)
    func adkrossInterstitialLoadedSuccessfully()
}
public class AdkrossInterstitial {
    
    private weak var delegate: AdkrossInterstitialDelegate?
    private var instertitialAd: CampaignLoadModel.Response?
    
    public init(delegate: AdkrossInterstitialDelegate) {
        self.delegate = delegate
    }
    
    var isInterstitialLoaded: Bool { instertitialAd != nil }
 
    public func load(campaignKey: String? = nil) {
        Adkross.shared.load(campaignKey: campaignKey) { [weak self] response in
            guard let strongSelf = self else { return }
            guard let strongDelegate = strongSelf.delegate else { return }
            
            if let error = response.error {
                guard let message = error.message else { return }
                
                strongDelegate.adkrossInterstitial(failedWith: message)
                return
            }
            
            guard let responseData = response.data else { return }
            
            strongSelf.instertitialAd = responseData
            
            strongDelegate.adkrossInterstitialLoadedSuccessfully()
        }
    }

}
