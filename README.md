# JSON-RPC-HTTP-Call

SIGHTED is a **privacy-preserving dApp** that integrates the **Internet Computer Protocol (ICP)** as the frontend and **Calimero private shards** as the backend for secure, decentralized token verification and data management. This project demonstrates how to use **ICP canister HTTPS outcalls** to interact with Calimero's **JSON-RPC API**, enabling **token management**, **transaction validation**, and **private data handling**.

---

## **Architecture Overview**

1. **ICP Frontend (`main.mo`)**:  
   - Sends HTTPS POST requests to Calimero using **JSON-RPC** for balance checks and transaction verification.
   - Manages and tracks requests for real-time responses from Calimero.  
   
   This will act as an on-chain API for your NEAR/Calimero environment that interacts with the private shards through Calimero SDK.

   Calimero JSON-RPC API: Used for data access, token verification, and shard communication.
   NEAR RPC API: You can also combine NEAR APIs with Calimero-specific APIs to read or verify data stored on the Calimero shards.

    Steps to Build an On-Chain API for NEAR/Calimero on ICP
   ICP Canister with HTTPS Outcalls
   Use Motoko to make HTTPS requests to Calimero's JSON-RPC or NEAR's RPC API.


3. **Calimero Backend (`Node.js`)**:  
   - Implements a **JSON-RPC server** that processes requests from the ICP frontend.  
   - Handles **get_balance**, **verify_transaction**, and other data verification methods.  

   Calimero Backend
   Set up a Calimero API server that interacts with your NEAR on-chain data and processes requests.
   Data Retrieval & Validation
   Fetch and validate data from Calimero shards using RPC calls and return it to ICP.

---

## **Features**
- **Privacy-Preserving Token Verification**: Uses Calimero private shards for transaction proofs.  
- **Cross-Chain Communication**: Relays token balances and verification proofs via **ICP HTTPS outcalls**.  
- **JSON-RPC API Support**: Enables seamless backend integration with Calimero.




---

## **Installation Instructions**

### Prerequisites
- **DFX CLI**: [Install DFX CLI](https://internetcomputer.org/docs/current/developer-docs/setup/install/)  
- **Node.js**: For running the Calimero backend.  
  ```bash
  sudo apt install nodejs npm
  ```

---

### **Steps to Run Locally**

1. **Clone the Repository**
   ```bash
   git clone https://github.com/your-repo/sighted-icp-calimero.git
   cd sighted-icp-calimero
   ```

2. **Start Calimero Backend (Node.js)**
   ```bash
   cd backend
   node calimero-backend.js
   ```

3. **Start ICP Local Replica**
   ```bash
   dfx start --background
   ```

4. **Deploy the ICP Canister**
   ```bash
   dfx deploy
   ```

---

## **Usage**

### **ICP Canister Code (`main.mo`)**

**Example HTTPS Outcall to Calimero**  
```motoko
public func callCalimeroRpc(method: Text, params: Text): async ?Text {
  let url = "https://api.calimero.network/rpc";
  let body = Text.concat("{\"jsonrpc\":\"2.0\",\"method\":\"", method, "\",\"params\":", params, ",\"id\":1}");
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
}
```

### **Calimero JSON-RPC Backend (`calimero-backend.js`)**

```javascript
app.post('/rpc', (req, res) => {
  const { method, params } = req.body;

  if (method === 'get_balance') {
    res.json({ jsonrpc: "2.0", result: { balance: 1000 }, id: 1 });
  } else if (method === 'verify_transaction') {
    res.json({ jsonrpc: "2.0", result: { isValid: true }, id: 1 });
  } else {
    res.status(400).json({ error: "Method not found" });
  }
});
```

### **Sample JSON-RPC Request**

**Request (`POST`):**
```json
{
  "jsonrpc": "2.0",
  "method": "get_balance",
  "params": {
    "userId": "user123"
  },
  "id": 1
}
```

**Response (`200 OK`):**
```json
{
  "jsonrpc": "2.0",
  "result": {
    "balance": 1000
  },
  "id": 1
}
```
