import SwiftUI

struct CustomLayout: Layout {
    var verticalSpacing: CGFloat = 0
    var horizontalSpacing: CGFloat = 0

    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        guard !subviews.isEmpty else { return .zero }
        // 모든 자식 부의 제안된 크기를 계산하여 최대 너비와 높이를 반환
        // 레이아웃의 전체 크기를 결정. 제공된 `LayoutProposal`과 자식 뷰를 기반으로 크기를 계산한다.
        // proposal: 레이아웃의 크기를 제안, 원하는 크기를 포함 할 수있다.
        // subviews: 레이아웃의 자식 뷰들
        // cach: 크기 계산을 최적화 하기 위해 사용할 수 있는 캐시
//        var maxWidth: CGFloat = 0
//        var maxHeight: CGFloat = 0

//        print("proposal.width: ", proposal.width)

//        for subview in subviews {
//            let size = subview.sizeThatFits(proposal)
        ////            print("maxWidthz:", maxWidth, "size.width:", size.width)
//            maxWidth = max(maxWidth, size.width)
//            maxHeight += size.height
//        }

//        print("width:", maxWidth, "height:", maxHeight)

//        return CGSize(width: maxWidth, height: maxHeight)
        return CGSize(width: proposal.width ?? 0, height: proposal.height ?? 0)
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        // 자식 뷰를 수직으로 배치
        // 레이아웃 내에서 자식 뷰를 실제로 배치하는 역할, 각 자식 뷰의 위치를 결정
        // bounts: 레이아웃의 경계, 이 영역 내에서 자식 뷰를 배치
        // subviews: 레이아웃의 자식뷰
        // cache: 배치를 최적화하기 위해서 사용할 수 있는 캐시
//        var yOffset: CGFloat = 0
//        let viewWidth = proposal.width ?? 0
//        print("viewWidht: ", viewWidth)
//
//        var currentWidth: CGFloat = 0
//        for subview in subviews {
//            let size = subview.sizeThatFits(proposal)
//
//            print("currentWidth: ", size.width, currentWidth)
        ////            print("bounds.minX:", bounds.minX)
        ////            print("yOffset: ", yOffset)
//
//            if viewWidth <= currentWidth {
//                print("enter")
//                currentWidth = 0
//                yOffset += size.height
//            }
//
//            subview.place(
//                at: CGPoint(x: currentWidth, y: bounds.minY + yOffset),
//                proposal: proposal
//            )
//            currentWidth += size.width
//
        ////            yOffset += size.height
//        }
        var sumX: CGFloat = bounds.minX
        var sumY: CGFloat = bounds.minY

        for index in subviews.indices {
            let view = subviews[index]
            let viewSize = view.sizeThatFits(.unspecified)
            guard let propsalWidth = proposal.width else { continue }

            if sumX + viewSize.width > propsalWidth {
                sumX = bounds.minX
                sumY += viewSize.height
                sumY += verticalSpacing
            }

            let point = CGPoint(x: sumX, y: sumY)

            view.place(at: point, proposal: proposal)
            sumX += viewSize.width
            sumY += horizontalSpacing
        }
    }
}

struct ContentView: View {
    var body: some View {
        VStack(alignment: .center) {
            Text("Hello, ")
            CustomLayout {
                Text("Hello, World!")
                    .background(.red)
                Text("This is a custom layout.")
                    .background(.orange)
                Text("Each View is placed vertically.")
                    .background(.yellow)
                Text("Hello, I'm Developer, from PHP, Go. Are you ok?")
                    .background(.green)
                Text("Bye...")
                    .background(.blue)
            }
            .padding()
            .background(.purple)
        }
    }
}

#Preview {
    ContentView()
}
