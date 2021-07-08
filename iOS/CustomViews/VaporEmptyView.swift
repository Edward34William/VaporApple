//
//  VaporEmptyView.swift
//  VaporApple (iOS)
//
//  Created by Nguyen Phong on 7/15/21.
//

import SwiftUI

struct VaporEmptyView: View {
    var body: some View {
        Text("Empty")
            .bold()
            .foregroundColor(Color("facebook"))
    }
}

struct VaporEmptyView_Previews: PreviewProvider {
    static var previews: some View {
        VaporEmptyView()
    }
}
