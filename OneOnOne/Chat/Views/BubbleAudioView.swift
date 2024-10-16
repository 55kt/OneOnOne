//
//  BubbleAudioView.swift
//  OneOnOne
//
//  Created by Vlad on 16/10/24.
//

import SwiftUI

struct BubbleAudioView: View {
    
    // MARK: - Properties
    let item: MessageItem
    @State private var sliderValue: Double = 0
    @State private var sliderRange: ClosedRange<Double> = 0...20
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: item.horizontalAlignment, spacing: 3) {
            HStack {
                playButton()
                Slider(value: $sliderValue, in: sliderRange)
                    .tint(.gray)
                
                Text("01:19")
                    .foregroundStyle(.gray)
                
            }
            .padding(10)
            .background(Color.gray.opacity(0.4))
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            .padding(5)
            .background(item.backgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            .applyTail(item.direction)
            
            TimeStampText(item: item, time: "17:12")
        }
        .shadow(color: Color(.systemGray3).opacity(0.1), radius: 5, x: 0, y: 20)
        .frame(maxWidth: .infinity, alignment: item.alignment)
        .padding(.leading, item.direction == .received ? 5 : 100)
        .padding(.trailing, item.direction == .received ? 100 : 5)

    }
    
    // MARK: - Methods
    private func playButton() -> some View {
        Button {
            // Some action
        } label: {
            Image(systemName: "play.fill")
                .padding(10)
                .background(item.direction == .received ? .gray.opacity(0.8) : .gray.opacity(0.8))
                .clipShape(Circle())
                .foregroundStyle(item.direction == .received ? .white : .black)
        }
    }
}

// MARK: - Preview
#Preview {
    ScrollView {
        BubbleAudioView(item: .receivedPlaceholder)
        BubbleAudioView(item: .sentPlaceholder)
    }
    .frame(maxWidth: .infinity)
    .padding(.horizontal)
    .background(Color.gray.opacity(0.5))
}
