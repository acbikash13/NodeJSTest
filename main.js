const assert = require("assert");

class MyTest {
  constructor(){
    this.prodNames=["tv","laptop","notebook","phone"];
    this.prices=0//do it
    this.quantities=0///do it
  }
  changeProductName(id,newName){
    this.prodNames[id]=newName;
  }
  changeProductPrice(id,newPrice){
    //do it 
  }
  changeProductQuant(id,newQuant){
    //do it
  }
  getProductName(id){
    return this.prodNames[id];
  }
  getProductPrice(id){
    //do it
  }

 getProductQuant(id){
    //do it
  }}
let prod;

beforeEach(() => {
  prod = new MyTest();
});

describe("CheckingMyTest", () => {
  it("can chnage product name", () => {
    prod.changeProductName(0,"watch")
    assert.equal(prod.getProductName(0), "watch");
  });
  it("can chnage product price", () => {
   //do it by yourself
  });

 //create another it method to see if the changeProductQuant works or not
});