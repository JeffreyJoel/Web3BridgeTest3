import { ethers } from 'hardhat';

async function main() {
  try {
    const [deployer] = await ethers.getSigners();

    const JeffToken = await ethers.getContractFactory('JeffToken');
    const jeffToken = await JeffToken.deploy();
    await jeffToken.waitForDeployment();
    console.log(`JeffToken deployed at: ${jeffToken.target}`);
  } catch (error) {
    console.error(error);
    process.exitCode = 1;
  }
}

main();