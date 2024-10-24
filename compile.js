const path = require('path');
const fs = require('fs');
const solc = require('solc');

// Path to the Solidity contract
const ecommercePath = path.resolve(__dirname, 'contracts', 'Ecommerce.sol');
const source = fs.readFileSync(ecommercePath, 'utf8');

// Solidity compiler input format
let input = {
  language: "Solidity",
  sources: {
    "Ecommerce.sol": {
      content: source,
    },
  },
  settings: {
    outputSelection: {
      "*": {
        "*": ["abi", "evm.bytecode"],
      },
    },
  },
};

// Compile the contract
const stringInput = JSON.stringify(input);
const compiledCode = solc.compile(stringInput);
const output = JSON.parse(compiledCode);

// Access the compiled contract
const contractOutput = output.contracts["Ecommerce.sol"];
const ecommerceOutput = contractOutput.EcommerceV3Transfer; // Match this with the contract name

// Extract ABI and Bytecode
const ecommerceABI = ecommerceOutput.abi;
const ecommerceBytecode = ecommerceOutput.evm.bytecode.object;

console.log("ABI: ", ecommerceABI);
console.log("\n\n\nBytecode: ", ecommerceBytecode);

// Export the ABI and Bytecode for deployment
module.exports = { "abi": ecommerceABI, "bytecode": ecommerceBytecode };

