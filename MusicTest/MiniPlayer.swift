//
//  MiniPlayer.swift
//  MusicTest
//
//  Created by Константин Лопаткин on 26.07.2023.
//

import SwiftUI

struct MiniPlayer: View {
    @Binding var expand: Bool
    let height = UIScreen.main.bounds.height / 3
   
    let safeArea = UIApplication.shared.windows.first?.safeAreaInsets
    @State var viewHeight: CGFloat = 60
    @State var offset: CGFloat = 0
    @State var offsetImage: CGFloat = 0
    @State var scale: CGFloat = 40
    var body: some View {
        VStack {
            if expand {
                Capsule()
                    .fill(.gray)
                    .frame(width: expand ? 60 : 0, height: expand ? 4 : 0)
                    .padding(.top, expand ? safeArea?.top : 0)
                    .onTapGesture {
                        withAnimation(.spring()) {
                            expand = false
                            scale = 40
                        }
                    }
                    .padding(.vertical, expand ? 20 : 0)
                    .opacity(expand ? 1 : 0)
            }
            
            
            HStack(alignment: .center) {
                Image(systemName: "music.note")
                    .foregroundColor(.white)
                    .scaleEffect(x: expand ? 3 : 1, y: expand ? 3 : 1)
                    .frame(width: scale, height: scale)
                    .background(.ultraThinMaterial)
                    .background(expand ? Color.gray : Color.black)
                    .cornerRadius(8)
                    .offset(x: !expand ? -offsetImage : 0)
                if !expand {
                    Spacer()
                }
                
            }
            .padding(.leading)
            .frame(maxWidth: .infinity)
            
            if expand {  Spacer() }
        }
        .frame(maxWidth: expand ? .infinity : (UIScreen.main.bounds.width - 10), maxHeight: expand ? .infinity : viewHeight, alignment: .leading)
        .background(.ultraThinMaterial)
        .background(expand ? Color.black : Color.white)
        .cornerRadius(12)
        .shadow(radius: 20, x: 0, y: 16)
        .onTapGesture {
            withAnimation(.spring()) {
                expand = true
                scale = height
            }
        }
        .offset(y: expand ? 0 : -48)
        .offset(y: offset)
        .gesture(
            DragGesture()
                .onChanged(onChanged(_:))
                .onEnded(onEnded(_:))
        )
        .ignoresSafeArea()
    }
    func onChanged(_ value: DragGesture.Value) {
        if value.translation.height > 0 && expand {
            offset = value.translation.height
        }
        if value.translation.height < 0 && !expand {
            viewHeight -= value.translation.height
            scale -= value.translation.height / 3
            offsetImage += value.translation.height / 20
        }
        
        print(value.translation.height)
    }
    func onEnded(_ value: DragGesture.Value) {
        withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.95, blendDuration: 0.7)) {
            if value.translation.height > height {
                expand = false
                viewHeight = 60
                scale = 40
                
            } else {
                expand = true
                scale = height
            }
            offset = 0
            offsetImage = 0
        }
    }
}
struct MiniPlayer_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
