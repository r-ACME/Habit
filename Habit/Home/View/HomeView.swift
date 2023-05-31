//
//  HomeView.swift
//  Habit
//
//  Created by coltec on 25/04/23.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var viewModel: HomeViewModel
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: HomeViewModel())
    }
}
