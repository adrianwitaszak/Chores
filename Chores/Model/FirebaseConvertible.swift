//
// Created by Adrian Witaszak on 28/07/2022.
//

import Foundation

protocol FirebaseConvertable {
    func toDocument(userId: String) -> [String: Any]
}