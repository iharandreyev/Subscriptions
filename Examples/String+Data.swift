//
//  String+Data.swift
//  Subscriptions
//
//  Created by Ihar Andreyeu on 1/4/23.
//  Copyright © 2023 Ihar Andreyeu. All rights reserved.
//

import Foundation

extension String {
    func data(using encoding: Encoding, allowLossyConversion: Bool = false) throws -> Data {
        guard let data = self.data(using: encoding, allowLossyConversion: allowLossyConversion) else {
            throw EncodingError.invalidValue(self, .init(codingPath: [], debugDescription: "Unable to encode `\(self)` using `\(encoding)`"))
        }
        return data
    }
}
