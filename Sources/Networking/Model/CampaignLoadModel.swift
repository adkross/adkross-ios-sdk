//
//  CampaignLoadModel.swift
//  
//
//  Created by Furkan Kaplan on 5.07.2022.
//

import Foundation

public struct CampaignLoadModel {

    public struct Request: Encodable {
        let campaignKey: String?
    }
    
    public struct Response: Decodable {
        let title: String?
        let description: String?
        let imageUrl: URL?
        let linkCTA: URL?
    }
}
