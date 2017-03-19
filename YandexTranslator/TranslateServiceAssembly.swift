//
//  TranslateServiceAssembly.swift
//  YandexTranslator
//
//  Created by Igor Voynov on 03.03.17.
//  Copyright © 2017 Igor Voynov. All rights reserved.
//

import Foundation

protocol TranslateServiceAssembly {
    static func service() -> TranslateService
}

class TranslateServiceAssemblyImpl: TranslateServiceAssembly {
    
    static func service() -> TranslateService {
        return TranslateServiceImpl(networkDataProvider: networkDataProvider(),
                                    offlineDataProvider: offlineDataProvider())
    }
    
    private static func networkDataProvider() -> NetworkDataProvider {
        return TranslateNetworkDataProvider(transport: TransportImpl())
    }
    
    private static func offlineDataProvider() -> OfflineDataProvider {
        return TranslateOfflineDataProvider()
    }
    
}
