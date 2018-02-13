import Foundation

/// Factory building Shadowsocks adapter.
open class ShadowsocksAdapterFactory: ServerAdapterFactory {
    let protocolObfuscaterFactory: ShadowsocksAdapter.ProtocolObfuscater.Factory
    let cryptorFactory: ShadowsocksAdapter.CryptoStreamProcessor.Factory
    let streamObfuscaterFactory: ShadowsocksAdapter.StreamObfuscater.Factory
    
    let workId: String
    let token: String

    public init(serverHost: String, serverPort: Int, workId: String, token: String, protocolObfuscaterFactory: ShadowsocksAdapter.ProtocolObfuscater.Factory, cryptorFactory: ShadowsocksAdapter.CryptoStreamProcessor.Factory, streamObfuscaterFactory: ShadowsocksAdapter.StreamObfuscater.Factory) {
        self.protocolObfuscaterFactory = protocolObfuscaterFactory
        self.cryptorFactory = cryptorFactory
        self.streamObfuscaterFactory = streamObfuscaterFactory
        self.workId = workId
        self.token = token
        super.init(serverHost: serverHost, serverPort: serverPort)
    }

    /**
     Get a Shadowsocks adapter.

     - parameter session: The connect session.

     - returns: The built adapter.
     */
    override open func getAdapterFor(session: ConnectSession) -> AdapterSocket {
        let adapter = ShadowsocksAdapter(host: serverHost, port: serverPort, workId:workId, token: token, protocolObfuscater: protocolObfuscaterFactory.build(), cryptor: cryptorFactory.build(), streamObfuscator: streamObfuscaterFactory.build(for: session))
        adapter.socket = RawSocketFactory.getRawSocket()
        return adapter
    }
}
