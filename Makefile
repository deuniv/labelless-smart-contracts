all:
	npx hardhat compile
	cp -Rf artifacts counter-app/src/
	sol-merger --remove-comments contracts/Counter.sol
	mv contracts/Counter_merged.sol release
	npx hardhat run scripts/deploy-counter-script.js --network localhost

clean:
	rm -f contracts/Counter_merged.sol
