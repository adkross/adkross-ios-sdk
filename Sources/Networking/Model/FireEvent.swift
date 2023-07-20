//
//  FireEvent.swift
//
//
//  Created by Furkan Kaplan on 21.06.2023.
//

import Foundation

struct FireEvent {

    struct Request: Encodable {
        let analyticEventType: EventType
        let campaignKey: String
    }

    struct Response: Decodable {/* No need to response*/}
}
