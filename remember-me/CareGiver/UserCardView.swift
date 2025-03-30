import SwiftUI

struct UserCardView: View {
    let user: User
    @Binding var isFollowing: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(user.name)
                .font(.title2)
                .bold()

            HStack {
                Label("Age: \(user.age)", systemImage: "calendar")
                Spacer()
                Label("Type: \(user.accountType)", systemImage: "person.crop.circle")
            }
            .font(.subheadline)
            .foregroundColor(.secondary)

            Divider()

            HStack {
                Label(user.email, systemImage: "envelope")
                    .font(.subheadline)

                Spacer()

                Button(action: {
                    withAnimation {
                        isFollowing.toggle()
                    }
                }) {
                    HStack {
                        Image(systemName: isFollowing ? "checkmark.circle.fill" : "plus.circle")
                        Text(isFollowing ? "Following" : "Follow")
                    }
                    .padding(.vertical, 6)
                    .padding(.horizontal, 12)
                    .background(isFollowing ? Color.green.opacity(0.2) : Color.blue.opacity(0.2))
                    .foregroundColor(isFollowing ? .green : .blue)
                    .cornerRadius(12)
                }
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(16)
        .shadow(color: .gray.opacity(0.2), radius: 8, x: 0, y: 4)
        .padding(.horizontal)
    }
}


#Preview {
    StatefulPreviewWrapper(true) { isFollowing in
        UserCardView(user: User(
            name: "Mathew Boyd",
            age: "28",
            email: "mathew@example.com",
            accountType: "Patient"
        ), isFollowing: isFollowing)
    }
}
