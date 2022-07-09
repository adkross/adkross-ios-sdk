//
//  AdkrossInterstitial.swift
//  
//
//  Created by Furkan Kaplan on 9.07.2022.
//

import Foundation

public class AdkrossInterstitial {
 
    public func load(campaignKey: String? = nil) {
        Adkross.shared.load(campaignKey: campaignKey) { response in
            
        }
    }

}
