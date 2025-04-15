//
//  HomeView.swift
//  Seena_Pay
//
//  Created by Abdallah Elgedawy on 14/04/2025.
//



import SwiftUI


let easyRecipes = [
    (image: "Frame 89", title: "Scrambled Egg", rating: "4.9", reviews: "5k", chef: "Gordon Ramsay"),
    (image: "Frame 90", title: "Grilled Cheese Sandwich", rating: "4.9", reviews: "4k", chef: "Alain Ducasse"),
    (image: "Frame 94", title: "Pasta with Garlic and Olive Oil", rating: "4.8", reviews: "3.5k", chef: "Yannick Alléno")
]

let egyptianRecipes = [
    (image: "Frame 92", title: "Nasi Goreng Rendang", rating: "5", reviews: "7k", chef: "William Wongso"),
    (image: "Frame 93", title: "Coto Makassar", rating: "4.9", reviews: "1k", chef: "Arnold Poernomo"),
    (image: "Frame 91", title: "Ayam Betutu", rating: "4.9", reviews: "2k", chef: "Juna Rorimpandey")
]


struct HomeView: View {
    @State private var selectedTab: Tab = .home

    var body: some View {
        VStack(spacing: 0) {
            // Main content switching based on selected tab
            Group {
                switch selectedTab {
                case .home:
                    MainHomeContentView() // full content here
                case .search:
                    EmptyViewWithTitle(title: "Search")
                case .add:
                    EmptyViewWithTitle(title: "Add Something")
                case .favorite:
                    EmptyViewWithTitle(title: "Favorites")
                case .profile:
                    EmptyViewWithTitle(title: "Profile")
                }
            }
            TabBar(selectedTab: $selectedTab)
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct MainHomeContentView: View {
    var body: some View {
        VStack(spacing: 0) {
            GreetingBar()
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 24) {
                    RecipeCard()
                    CategoryGrid()
                    HorizontalRecipeSection(title: "Easy & Simple Recipe", recipes: easyRecipes)
                    
                    Rectangle()
                        .fill(Color.gray.opacity(0.2))
                        .frame(height:8)
                        .padding(.top, 8)
                    
                    HorizontalRecipeSection(title: "Egyptian Food", recipes: egyptianRecipes)
                }
                .padding(.vertical)
                .padding(.horizontal)
            }
        }
    }
}

struct GreetingBar: View {
    var body: some View {
        GeometryReader { geometry in
            HStack {
                // Left: Logo + Text
                HStack(spacing: 8) {
                    Image("seena_logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)

                    Text("Hello, Seena Pay")
                        .font(.headline)
                        .foregroundColor(.black)
                        .lineLimit(1)
                        .minimumScaleFactor(0.7)
                        .layoutPriority(1)
                }

                Spacer()

                // Right: Bell
                Button(action: {}) {
                    ZStack(alignment: .topTrailing) {
                        Image("mdi_bell")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                            .foregroundColor(.black)
                    }
                }
            }
            .padding(.trailing,20)
            .frame(width: geometry.size.width)
            .padding(.horizontal)
            .padding(.vertical, 10)
            .background(Color.white)
        }
        .frame(height: 60) // fixed height
    }
}

struct RecipeCard: View {
    @State private var isFavorite: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            // Top image section with "Daily Recipe" label and bookmark button
            ZStack {
                Image("pasta")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 170)
                    .clipped()

                // Overlay content
                VStack {
                    // Top row with Daily Recipe and Bookmark
                    HStack(alignment: .top) {
                        Text("Daily Recipe")
                            .font(.caption)
                            .bold()
                            .padding(.horizontal, 12)
                            .padding(.vertical, 10)
                            .background(Color(hex: "DB1414"))
                            .foregroundColor(.white)
                            .cornerRadius(16)
                        
                        
                        Spacer()
                        
                        // Bookmark button
                        Button(action: {
                            isFavorite.toggle()
                        }) {
                            Image("mdi_bookmark-outline")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 18, height: 18)
                                .foregroundColor(.black)
                                .padding(8)
                                .background(Color.white)
                                .cornerRadius(8)
                        }
                    }
                    .padding(.horizontal)
                    Spacer()
                    
                    // Bottom row with rating
                    HStack {
                        Spacer()
                        HStack(spacing: 4) {
                            Image("mdi_star")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundColor(.red)
                            
                            Text("4.9")
                                .font(.system(size: 16))
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 12)
                        .background(
                            Capsule()
                                .fill(Color.white)
                        )
                    }
                    .padding(.horizontal)
                }
                .padding()
                
            }
            
            // Title row section
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Pasta Primavera")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Text("by Nadine Hettinger")
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.9))
                }
                
                Spacer()
                
                Text("Italian")
                    .font(.body)
                    .fontWeight(.medium)
                    .foregroundColor(Color(hex: "DB1414"))
                    .padding(.horizontal, 16)
                    .padding(.vertical, 10)
                    .background(Color.white)
                    .cornerRadius(20)
            }
            .padding(.trailing)
            .padding(.horizontal, 20)
            .padding(.vertical, 16)
            .background(Color(hex: "DB1414"))
            // Add this after your red title section
            ZStack {
                // White rectangle with rounded top corners
                RoundedTopRectangle(cornerRadius: 15)
                    .fill(Color.white)
                    .frame(height: 55)
                    .offset(y: -8)
                    .padding(.horizontal)
                
                // Handle
                Capsule()
                    .fill(Color(hex: "D9D9D9"))
                    .frame(width: 60, height: 5)
            }
            .zIndex(1) // Ensure it's above the title section
        }
        .cornerRadius(16)
    }
}

struct RoundedTopRectangle: Shape {
    var cornerRadius: CGFloat = 15

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: [.topLeft, .topRight],
            cornerRadii: CGSize(width: cornerRadius, height: cornerRadius)
        )
        return Path(path.cgPath)
    }
}

struct CategoryGrid: View {
    let categories = ["Breakfast", "Lunch", "Dinner", "Dessert", "Western", "Asian", "Drinks", "Meat"]
    
    // Mapping categories to images
    let categoryImages: [String: String] = [
        "Breakfast": "mdi_baguette",
        "Lunch": "mdi_food",
        "Dinner": "mdi_food-drumstick",
        "Dessert": "mdi_ice-cream",
        "Western": "mdi_pizza",
        "Asian": "mdi_rice",
        "Drinks": "mdi_glass-cocktail",
        "Meat": "mdi_food-steak"
    ]

    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 8),
        GridItem(.flexible(), spacing: 8),
        GridItem(.flexible(), spacing: 8),
        GridItem(.flexible(), spacing: 8)
    ]

    var body: some View {
        LazyVGrid(columns: columns, spacing: 16) {
            ForEach(categories, id: \.self) { category in
                VStack(spacing: 8) {
                    ZStack {
                        Circle()
                            .stroke(Color.gray, lineWidth: 1)
                            .frame(width: 60, height: 60)
                            .background(Circle().fill(Color.white))

                        // Dynamically load image based on the category
                        if let imageName = categoryImages[category] {
                            Image(imageName)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                        }
                    }

                    Text(category)
                        .font(.caption)
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                        .frame(width: 70)
                }
            }
        }
        .padding(.all)
        .padding(.leading,10)
        .padding(.trailing,10)
        .padding(.horizontal)
    }
}

struct SectionHeader: View {
    var title: String
    
    var body: some View {
        HStack {
            Text(title)
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(Color(hex: "002366")) // Navy blue color from the image
            
            Spacer()
            
            Text("See More")
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundColor(Color(hex: "DB1414"))
            // Same red as your recipe card
        }
        .padding(.horizontal,25)
        .padding(.vertical, 8)
    }
}

struct HorizontalRecipeSection: View {
    var title: String
    var recipes: [(image: String, title: String, rating: String, reviews: String, chef: String)]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Section header
            HStack {
                Text(title)
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(Color.black)
                
                Spacer()
                
                Text("See More")
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundColor(Color(hex: "DB1414"))
            }
            .padding()
            .padding(.horizontal)
            
            // Scrollable recipe cards
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(0..<recipes.count, id: \.self) { index in
                        CompactRecipeCard(
                            image: recipes[index].image,
                            title: recipes[index].title,
                            rating: recipes[index].rating,
                            reviews: recipes[index].reviews,
                            chef: recipes[index].chef
                        )
                    }
                }
                .padding(.leading,5)
                .padding(.horizontal)
            }
            
            // Divider
        }
    }
}

struct CompactRecipeCard: View {
    var image: String
    var title: String
    var rating: String
    var reviews: String
    var chef: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            // Image with fixed width and height to match screenshot
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 120, height: 90)
                .cornerRadius(8)
                .clipped()
            
            // Title
            Text(title)
                .font(.system(size: 14, weight: .bold))
                .lineLimit(2)
                .frame(width: 120, height: 36, alignment: .topLeading)
            
            // Rating
            HStack(spacing: 2) {
                Image("Vector")
                    .resizable()
                    .frame(width: 12, height: 12)
                Text("\(rating) | \(reviews) Reviews")
                    .font(.system(size: 10))
                    .foregroundColor(.gray)
            }
            
            // Chef
            HStack(spacing: 4) {
                Image("Vector 1")
                    .resizable()
                    .frame(width: 12, height: 12)
                    .foregroundColor(Color(hex: "DB1414"))
                
                Text(chef)
                    .font(.system(size: 10))
                    .fontWeight(.medium)
                    .foregroundColor(.black)
                    .underline()
            }
        }
        .frame(width: 120)
    }
}

struct CurvedContainerWithHandle: View {
    var body: some View {
        VStack(spacing: 0) {
            // Top part with handle and curved edges
            ZStack {
                // Gray handle in center
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 60, height: 5)
                    .cornerRadius(2.5)
            }
            .frame(height: 50)
            
        }
    }
}
struct TabBar: View {
    @Binding var selectedTab: Tab

    var body: some View {
        HStack {
            tabItem(image: selectedTab == .home ? "Vector 2" : "Vector 3", tab: .home)
            tabItem(image: selectedTab == .search ? "Vector 4" : "Vector 5", tab: .search)
            
            ZStack {
                Circle()
                    .fill(Color(hex: "DB1414"))
                    .frame(width: 60, height: 60)
                Image("Vector 6")
                    .foregroundColor(.white)
            }
            .frame(maxWidth: .infinity)
            .onTapGesture {
                selectedTab = .add
            }

            tabItem(image: selectedTab == .favorite ? "Vector 7" : "Vector 8", tab: .favorite)
            tabItem(image: selectedTab == .profile ? "Vector 9" : "Vector 10", tab: .profile)
        }
        .padding(.top, 10)
        .padding(.bottom, 20)
        .background(Color.white.shadow(radius: 5))
    }

    @ViewBuilder
    private func tabItem(image: String, tab: Tab) -> some View {
        VStack(spacing: 4) {
            Image(image)
            if selectedTab == tab {
                Capsule()
                    .fill(Color.red)
                    .frame(width: 20, height: 4)
            } else {
                Spacer().frame(height: 4)
            }
        }
        .frame(maxWidth: .infinity)
        .onTapGesture {
            selectedTab = tab
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HomeView()
                .previewDevice("iPhone 14 Pro")
            HomeView()
                .previewDevice("iPhone 7")
        }
    }
}

struct EmptyViewWithTitle: View {
    let title: String

    var body: some View {
        VStack {
            Text(title)
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
            Spacer()
        }
    }
}


enum Tab: Int {
    case home, search, add, favorite, profile
}

