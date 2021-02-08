const basicMath = artifacts.require("basicMath");

contract("basicMath", async accounts => {
  it("should not overflow", async () => {
   try {
    // Try to add 2^256 - 1 and 5 (should overflow and throw an exception)
    const addResult = contractInstance.add((2**256 - 1), 5)
    assert.ok(false, "Threw an exception instead of overflowing.")
   }
   catch(error) {
    assert.ok(true, "Caught the exception.")
   }
  })
});
