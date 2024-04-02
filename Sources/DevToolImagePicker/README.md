# ImagePicker

A description of this package.

## Usage

```swift
struct TestView: View {
    @State var first: UIImagePickerController.SourceType? = nil
    @State var second = false
    @State var third = false

    @State var image: Image?

    var body: some View {
        ZStack {
            self.image?
                .resizable()
                .blur(radius: 12)
                .edgesIgnoringSafeArea(.all)

            VStack {
                Button("First") { self.first = .photoLibrary }
                Button("Camera") { self.first = .camera }
                Button("Second") { self.second = true }
                Button("Third") { self.third = true }
            }
            .padding()
            .background(Color.white)
            .font(.title.bold())
            .imagePicker(self.$first, adaptation: .fullScreenCover) { self.image = Image(uiImage: $0) }
            .imagePicker(self.$second) { self.image = Image(uiImage: $0) }
            .sheet(isPresented: self.$third) {
                ImagePickerView(sourceType: .photoLibrary) { self.image = Image(uiImage: $0) }
            }
        }
    }
}
```
