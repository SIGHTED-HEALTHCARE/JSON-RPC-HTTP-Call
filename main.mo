import Text "mo:base/Text";
import Http "mo:base/Http";

actor {
  /// Send an HTTP POST request to Calimero JSON-RPC endpoint
  public func callCalimeroRpc(method: Text, params: Text): async ?Text {
    let url = "https://api.calimero.network/rpc";
    let body = Text.concat(Text.concat("{\"jsonrpc\":\"2.0\",\"method\":\"", method), Text.concat("\",\"params\":", Text.concat(params, ",\"id\":1}")));

    let headers = [("Content-Type", "application/json")];

    let response = await Http.post(url, headers, body);
    switch (response.status) {
      case (200) {
        let responseBody = await response.body();
        return ?responseBody;
      };
      case (_) {
        return null;
      };
    };
  };
}
