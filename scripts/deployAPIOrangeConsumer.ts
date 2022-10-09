import { ethers } from "hardhat";

const URL = "https://yecrtkzs4ngovinrcdyn4j5k540vecyz.lambda-url.us-east-1.on.aws/price?market=market1&product=oranges";

async function main() {
  const APIOrangeConsumer = await ethers.getContractFactory("APIOrangeConsumer");
  const apiOrangeConsumer = await APIOrangeConsumer.deploy(URL);

  await apiOrangeConsumer.deployed();

  console.log(`APIOrangeConsumer deployed to ${apiOrangeConsumer.address}`);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
