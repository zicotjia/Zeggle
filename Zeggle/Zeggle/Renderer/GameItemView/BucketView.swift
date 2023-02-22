//
//  BucketView.swift
//  Zeggle
//
//  Created by Zico on 21/2/23.
//

import SwiftUI

struct BucketView: View {
    @Binding var bucket: Bucket

    var body: some View {
        Image(ImageNameToFile.bucket)
            .resizable()
            .frame(width: bucket.physicsBody.width.magnitude, height: bucket.physicsBody.height.magnitude)
            .position(x: bucket.physicsBody.centre.hVector.magnitude,
                      y: bucket.physicsBody.centre.vVector.magnitude)
            .zIndex(0)
    }
}

struct BucketView_Previews: PreviewProvider {

    static let bucket = Bucket(centre: PhysicsVector2D(horizontal: 400, vertical: 800))

    static var previews: some View {
        BucketView(bucket: .constant(bucket))
    }
}
