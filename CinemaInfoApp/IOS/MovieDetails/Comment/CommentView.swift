//
//  ReviewComment.swift
//  CinemaInfoApp
//
//  Created by MEESEON KANG on 2021/09/27.
//

import SwiftUI

struct CommentView: View {
    var screenX = UIScreen.main.bounds.width
    var review: Review
    var lastReviewStar: Int
    
    init(review: Review) {
        self.review = review
        
        lastReviewStar = review.ratingNum % 2
    }
    
    var body: some View {
        VStack {
            HStack {
                Text(review.writer)
                Spacer()
                
            }
            
            HStack {
                
                if review.ratingNum <= 0 && lastReviewStar <= 0 {
                    Text("평점 없음")
                }
                
                ForEach(0..<review.ratingNum / 2, id: \.self) { num in
                    Image(systemName: "star.fill")
                        .padding(.horizontal, -4)
                }
                
                if lastReviewStar > 0 {
                    Image(systemName: "star.leadinghalf.filled")
                }
                Spacer()
                
                Text(review.created)
                    .foregroundColor(.gray)
                
            }
            .padding(.leading, 6)
            .padding(.bottom, 1)
            .foregroundColor(.yellow)
            
            HStack() {
                Text(review.comment)
                Spacer()
            }
            
            Rectangle()
                .frame(width: screenX * 0.97, height: 1)
                .padding(.vertical, 4)
                .foregroundColor(.gray)
                
        }
        .foregroundColor(.white)
    }
}

struct ReviewComment_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            CommentView(review: exampleReview1)
            
        }
       
    }
}
