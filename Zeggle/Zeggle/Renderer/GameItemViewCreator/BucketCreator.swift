//
//  BuckerCreator.swift
//  Zeggle
//
//  Created by Zico on 21/2/23.
//

import Foundation
import SwiftUI

class BucketCreator {

    @ViewBuilder
    static func createBucket(item: ZeggleItem) -> some View {
        if let bucket = item as? Bucket {
            BucketView(bucket: .constant(bucket))
        } else {
            EmptyView()
        }
    }
}
