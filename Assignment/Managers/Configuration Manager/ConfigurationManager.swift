//
//  ConfigurationManager.swift
//  Assignment
//
//  Created by Vijay's Macbook on 21/08/20.
//  Copyright © 2020 Vijay. All rights reserved.
//

import UIKit

class ConfigurationManager: NSObject {
    
    fileprivate enum AppEnvironment: String {
        case development = "Development"
        case production = "Production"
    }
        
    fileprivate struct AppConfiguration {
        var apiEndPoint: String
        var environment: AppEnvironment
    }
    
    fileprivate var activeConfiguration: AppConfiguration!
    private static let _shared = ConfigurationManager()
    
    class func shared() -> ConfigurationManager {
        return _shared
    }
    
    private override init() {
        super.init()
        // Load application selected environment and its configuration
        if let environment = self.currentEnvironment() {
            self.activeConfiguration = self.configuration(environment: environment)
            if self.activeConfiguration == nil {
                assertionFailure(NSLocalizedString("Unable to load application configuration", comment: "Unable to load application configuration"))
            }
        } else {
            assertionFailure(NSLocalizedString("Unable to load application flags", comment: "Unable to load application flags"))
        }
    }
    
    private func currentEnvironment() -> AppEnvironment? {
        #if DEBUG
        return AppEnvironment.development
        #else
        return AppEnvironment.production
        #endif
    }
    
    /**
     Returns application active configuration
     
     - parameter environment: An application selected environment
     
     - returns: An application configuration structure based on selected environment
     */
    private func configuration(environment: AppEnvironment) -> AppConfiguration {
        switch environment {
        case .development:
            return debugConfiguration()
        case .production:
            return productionConfiguration()
        }
    }

    private func debugConfiguration() -> AppConfiguration {
        return AppConfiguration (
            apiEndPoint: "https://pixabay.com/api/?key=17991516-c15d8c400fc995d356cf14c32&",
            environment: .development
       )
    }
    
    private func productionConfiguration() -> AppConfiguration {
        return AppConfiguration(
            apiEndPoint: "https://pixabay.com/api/",
            environment: .production
       )
    }
}

extension ConfigurationManager {
    func applicationEnvironment() -> String {
        return self.activeConfiguration.environment.rawValue
    }
    
    func applicationEndPoint() -> String {
        return self.activeConfiguration.apiEndPoint
    }
}

