const { expect } = require("chai");

describe("ZappfiMerger", function () {
  it("Should deploy correctly", async function () {
    const Merger = await ethers.getContractFactory("ZappfiMerger");

    const merger = await Merger.deploy(
      ethers.ZeroAddress,
      ethers.ZeroAddress,
      ethers.ZeroAddress,
      1,
      1
    );

    expect(await merger.swapRatioA()).to.equal(1);
    expect(await merger.swapRatioB()).to.equal(1);
  });
});
