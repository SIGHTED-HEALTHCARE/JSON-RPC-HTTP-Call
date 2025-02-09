const express = require('express');
const bodyParser = require('body-parser');
const app = express();
app.use(bodyParser.json());

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

app.listen(3000, () => console.log('Calimero backend listening on port 3000'));
