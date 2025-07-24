import SwiftUI



struct ContentView: View {
    
    //This will keep track of the current bible quote index we are on while scrolling
    @State private var currentPage = 0
    //This will be set to all by default when we don't have a selected category
    @State private var selectedCategory: Category = .all
    //This will shuffle the bible quotes of the selected category so it is not just a static list ever single time we open it up
    @State private var shuffledQuotes: [BibleQuote] = []
    

    
    //This is our bookmark manger dude!
    @StateObject private var bookmarker = Bookmarker()
    
    //This is our note reflections dude!
    @StateObject private var reflectioner = Reflections()
    
    private func refreshQuotes() {
        let allQuotes = BibleQuote.sampleData(for: selectedCategory)
        let filtered = allQuotes.filter { quote in
            !bookmarker.bookmarkedQuotes.contains(where: { $0.text == quote.text })
        }
        shuffledQuotes = filtered.shuffled()
        currentPage = 0
    }
    
    var body: some View {
        NavigationView{
            ZStack(alignment: .topTrailing) {
                Color.white.ignoresSafeArea()
                
                if shuffledQuotes.isEmpty {
                        VStack {
                            Spacer()
                        Text("Congradulations you’ve bookmarked all quotes in this category, have fun writting reflections for them :)")
                                .font(.title3)
                                .foregroundColor(.gray)
                                .padding()
                            Spacer()
                        }
                    }else{
                        VStack {
                            
                            VerticalPager(pageCount: shuffledQuotes.count, currentIndex: $currentPage, onLoop:{
                                refreshQuotes()
                            }) {
                                ForEach(0..<shuffledQuotes.count, id: \.self) { index in
                                    VStack {
                                        Text("“\(shuffledQuotes[index].text)”")
                                            .font(.title2)
                                            .multilineTextAlignment(.center)
                                            .padding(.horizontal)
                                        
                                        Text(shuffledQuotes[index].formattedReference)
                                            .font(.subheadline)
                                            .foregroundColor(.secondary)
                                    }
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                                    .background(Color.white)
                                    .onTapGesture(count: 2){
                                        let haptic = UIImpactFeedbackGenerator( style: .heavy)
                                        haptic.impactOccurred()
                                        bookmarker.likeQuote(quote: shuffledQuotes[index])
                                        
                                    }
                                }
                            }
                            
                            
                            
                            Button(action: {
                                guard !shuffledQuotes.isEmpty, currentPage < shuffledQuotes.count else { return }
                                let quote = shuffledQuotes[currentPage]
                                bookmarker.toggleBookmark(quote: quote)
                            }){
                                let isBookmarked = bookmarker.isBookmarked(quote: shuffledQuotes[currentPage])
                                Image(systemName: isBookmarked ? "bookmark.fill" : "bookmark")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 28, height: 28)
                                    .foregroundColor(isBookmarked ? .blue : .gray)
                                    .padding()
                            }
                            
                            
                            Spacer()
                        }
                    }
                
                HStack{
                    NavigationLink(destination: BookmarkedTileView(bookmarker: bookmarker)){
                        Image(systemName: "bookmark.circle")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.blue)
                            .padding()
                    }
                    Spacer()
                    }
                    Menu {
                        ForEach(Category.allCases, id: \.self) { category in
                            Button {
                                selectedCategory = category
                                currentPage = 0
                            } label: {
                                Text(category.rawValue)
                            }
                        }
                    } label: {
                        Image("prayerHands")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .padding(20)
                    }
                }
            .onAppear{
                refreshQuotes()
            }
            }
        }
    }

        struct VerticalPager<Content: View>: View {
            let pageCount: Int
            @Binding var currentIndex: Int
            let content: Content
            var onLoop: (() -> Void)?
            
            init(pageCount: Int, currentIndex: Binding<Int>, onLoop: (() -> Void)? = nil, @ViewBuilder content: () -> Content) {
                self.pageCount = pageCount
                self._currentIndex = currentIndex
                self.content = content()
                self.onLoop = onLoop
            }
            
            @GestureState private var translation: CGFloat = 0
            
            
            
            var body: some View {
                GeometryReader { geometry in
                    LazyVStack (spacing:0) {
                        self.content
                            .frame(width: geometry.size.width, height: geometry.size.height)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.primary.opacity(0.000000001))
                    .offset(y: -CGFloat(self.currentIndex) * geometry
                        .size.height)
                    .offset(y: self.translation)
                    .animation(.easeInOut(duration: 0.3), value: currentIndex)
                    .animation(.easeInOut(duration: 0.2), value: translation)
                    .gesture(
                        DragGesture(minimumDistance: 1)
                            .updating(self.$translation) { value, state, _ in
                                state = value.translation.height
                            }
                            .onEnded { value in
                                let offset = value.translation.height
                                let velocity = value.velocity.height
                                let threshold = geometry.size.height / 2  // Keep this as CGFloat
                                
                                if abs(offset) > threshold || abs(velocity) > 200 {
                                    let direction = offset > 0 ? -1 : 1
                                    let newIndex = currentIndex + direction
                                    var didLoop = false
                                    
                                    if newIndex < 0 {
                                        currentIndex = pageCount - 1  // loop to last
                                        didLoop = true
                                    } else if newIndex >= pageCount {
                                        currentIndex = 0  // loop to first
                                        didLoop = true
                                    } else {
                                        currentIndex = newIndex
                                    }
                                    
                                    if didLoop {
                                        onLoop?()
                                    }
                                }
                            }
                        
                    )
                }
            }
    }


#Preview {
    ContentView()
}
