import Combine
import ComposableArchitecture
import ConvertSwift
import Foundation
import Starscream

public final class RootWebSocket {
    public var socket: WebSocket!
    
    init(path: String) {
        var request = URLRequest(url: URL(string: "ws://127.0.0.1:8080/" + path)!)
        request.timeoutInterval = 10
        socket = WebSocket(request: request)
        socket.delegate = self
        socket.connect()
    }
    
    func toEffect() -> Effect<WebSocketEvent, Never> {
        Effect.run { [weak self] subscriber in
            guard let self = self else {
                subscriber.send(completion: .finished)
                return AnyCancellable {}
            }
            self.socket.onEvent = {
                subscriber.send($0)
            }
            return AnyCancellable { [weak self] in
                self?.socket.disconnect()
            }
        }
    }
    
    func sendData(data: Data?) {
        if let data = data {
            socket.write(data: data)
        }
    }
    
    func sendString(string: String?) {
        if let string = string {
            socket.write(string: string)
        }
    }
    
    func sendModel(model: Encodable?) {
        if let data = model?.toData() {
            socket.write(data: data)
        }
    }
    
    deinit {
        socket.disconnect()
        socket.forceDisconnect()
    }
}

extension RootWebSocket: Starscream.WebSocketDelegate {
    public func didReceive(event: WebSocketEvent, client: WebSocket) {}
}

extension WebSocketEvent: Equatable {
    public static func == (lhs: WebSocketEvent, rhs: WebSocketEvent) -> Bool {
        switch lhs {
        case .ping:
            switch rhs {
            case .ping:
                return true
            default:
                return false
            }
        default:
            return false
        }
    }
}
