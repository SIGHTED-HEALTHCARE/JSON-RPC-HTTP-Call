import Text "mo:base/Text";
import Http "mo:base/Http";

actor CalimeroApi {
  /// Function to call Calimero JSON-RPC endpoint
  public func callCalimeroApi(method: Text, params: Text): async ?Text {
    let url = "https://api.calimero.network/rpc";  // Replace with actual Calimero API URL
    let body = Text.concat("{\"jsonrpc\":\"2.0\",\"method\":\"", method, "\",\"params\":", Text.concat(params, ",\"id\":1}"));
    let headers = [("Content-Type", "application/json")];

    let response = await Http.post(url, headers, body);
    switch (response.status) {
      case (200) {
        return await response.body();
      };
      case (_) {
        return null;
      };
    };
  };

  /// Example: Get NEAR account balance from Calimero
  public func getNearBalance(accountId: Text): async ?Text {
    let params = Text.concat("{\"accountId\":\"", accountId, "\"}");
    return await callCalimeroApi("get_balance", params);
  };
}
