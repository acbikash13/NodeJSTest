const assert = require("assert");
const ganache = require("ganache-cli");
const Web3 = require("web3");
const web3 = new Web3(ganache.provider());
const { abi, bytecode } = require("../compile");

let accounts;
let ecomm;
console.log('bytecode',bytecode); 

beforeEach(async () => {
  // Get a list of all accounts
  accounts = await web3.eth.getAccounts();
  console.log(accounts);
  ecomm = await new web3.eth.Contract(abi)
  .deploy({
    data: bytecode
  })
  .send({
    from: accounts[1],
    gasPrice: 8000000000,
    gas: 4700000
  });
  //Use your previous class activity solution
});

describe("Ecommerce ", () => {
  it("deploys a contract", () => {
    assert.ok(Ecommerce.options.address); // Test if contract address exists
  });

  it("checks owner", async () => {
    const name = //Do it by yourself
      assert.equal(name, "Shahid");
  });
  it("add products", async () => {

   await ecomm.methods.addProduct(1,"TV", 10, 100).send({ from: accounts[0], gasPrice: 8000000000, gas: 4700000 });
   const prod =  await ecomm.methods.productList(1).call();
   console.log(prod);
   assert.equal(prod.id, 1);
   assert.equal(prod.noItem, 10);
   assert.equal(prod.unitPrice, 100);

    //use productList array to get the product
    //use assert to check if the product id matches
    //use assert to check if the product noItem matches
    //use assert to check if the product unit price matches
  });
});
