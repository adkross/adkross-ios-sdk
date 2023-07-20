//
//  CampaignLoad.swift
//  
//
//  Created by Furkan Kaplan on 5.07.2022.
//

import Foundation

public struct CampaignLoad {

    public struct Request: Encodable {
        let campaignKey: String?
    }
    
    public struct Response: Decodable {
        let campaign: Campaign?
    }

    struct Campaign: Decodable {
        let id: String?;
        let title: String?
        let description: String?
        let campaignImageUrl: URL?
        let storeUrl: URL?
        let ctaText: String?
    }
}
