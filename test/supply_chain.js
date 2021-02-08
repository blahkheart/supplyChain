const SupplyChain = artifacts.require("supplyChain");

contract("SupplyChain", async accounts => {
  it("should create a participant", async () => {
    let instance = await SupplyChain.deployed();
    let participantId = await instance.addParticipant("A", "passA", "0x2F10D58d7eC1f97bBdF8C760f9350Fb4B657EADd", "Manufacturer");
    let participant = await instance.participants(0);
    assert.equal(participant[0], "A");
    assert.equal(participant[2], "Manufacturer");

    participantId = await instance.addParticipant('B', 'passB', '0x14C4836967F4A12B1Be2D812D9C500551F9b3257', 'Supplier');
    participant = await instance.participants(1);
    assert.equal(participant[0], "B");
    assert.equal(participant[2], "Supplier");

    participantId = await instance.addParticipant('C', 'passC', '0x4415E788d94Fc92E2A3e109C001553408965bc50', 'Consumer');
    participant = await instance.participants(2);
    assert.equal(participant[0], "C");
    assert.equal(participant[2], "Consumer");
  });
    

  it("should return participant details", async () => {
    let instance = await SupplyChain.deployed();
    let participantDetails = await instance.getParticipant(0);
    assert.equal(participantDetails[0], "A");

    instance = await SupplyChain.deployed();
    participantDetails = await instance.getParticipant(1);
    assert.equal(participantDetails[0], "B");

    instance = await SupplyChain.deployed();
    participantDetails = await instance.getParticipant(2);
    assert.equal(participantDetails[0], "C");
   
  });

});
