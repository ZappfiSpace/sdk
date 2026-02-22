const hre = require("hardhat");

async function main() {
  const Merger = await hre.ethers.getContractFactory("ZappfiMerger");

  const merger = await Merger.deploy(
    "0xTokenAAddress",
    "0xTokenBAddress",
    "0xMergedTokenAddress",
    1,
    2
  );

  await merger.waitForDeployment();

  console.log("ZappfiMerger deployed to:", await merger.getAddress());
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
