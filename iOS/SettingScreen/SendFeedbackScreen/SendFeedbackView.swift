import SwiftUI
import ComposableArchitecture

struct SendFeedbackView: View {
    
    let store: Store<SendFeedbackState, SendFeedbackAction>
    
    @State var textFeedback: String = ""
    
    var body: some View {
        WithViewStore(store) { viewStore in
            Form {
                
                Section(header: VStack{
                    Spacer().frame(height: 100)
                    Text("Feedback")
                }) {
                    TextField("Aa", text: $textFeedback)
                }
                
                Section {
                    HStack {
                        Spacer()
                        Button(action: {
                            
                        }, label: {
                            Text("Send")
                                .bold()
                                .foregroundColor(Color("facebook"))
                        })
                        Spacer()
                    }

                }
            }
        }
    }
}

struct SendFeedbackView_Previews: PreviewProvider {
    static var previews: some View {
        SendFeedbackView(store: Store(initialState: SendFeedbackState(), reducer: sendFeedbackReducer, environment: SendFeedbackEnvironment()))
    }
}
