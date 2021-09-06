const Web3 = require('web3');
const fs = require('fs');
const HDWalletProvider = require('@truffle/hdwallet-provider');

const mnemonic = fs.readFileSync(".secret").toString().trim();
const provider = new HDWalletProvider(mnemonic, `https://ropsten.infura.io/v3/5c67849d692d4bf48367f9071ccb36ca`)
const web3 = new Web3(provider);

const ERC20TransferABI = [
    {
      constant: false,
      inputs: [
        {
          name: "_to",
          type: "address",
        },
        {
          name: "_value",
          type: "uint256",
        },
      ],
      name: "transfer",
      outputs: [
        {
          name: "",
          type: "bool",
        },
      ],
      payable: false,
      stateMutability: "nonpayable",
      type: "function",
    },
    {
      constant: true,
      inputs: [
        {
          name: "_owner",
          type: "address",
        },
      ],
      name: "balanceOf",
      outputs: [
        {
          name: "balance",
          type: "uint256",
        },
      ],
      payable: false,
      stateMutability: "view",
      type: "function",
    },
  ]

const contractAddress = "0x09f113Bf5530EA98b5e178c0194E7736635242f6"

const contract = new web3.eth.Contract(ERC20TransferABI, contractAddress);

const senderAddress = "0x471BFf31d7D607b734efBFf7c54963bc1E2c68a5"
const receiverAddress = "0x1C9c5D82e8b109533e429E5f4dA09d64e673E0ed"


contract.methods.balanceOf(senderAddress).call(function (err, res) {
  if (err) {
    console.log("An error occured", err)
    return
  }
  console.log("The token balance is: ", res)
})

web3.eth.getBalance(senderAddress, function(err, res) {
  if (err) {
    console.log("An error occured", err)
    return
  }
  console.log("The eth balance is: ", res)
});


contract.methods
  .transfer(receiverAddress, web3.utils.toWei('2300', 'ether'))
  .send({ from: senderAddress }, function (err, res) {
    if (err) {
      console.log("An error occured", err)
      return
    }
    console.log("Hash of the transaction: " + res)
  })
