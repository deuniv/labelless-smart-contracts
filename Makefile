all:
	npx hardhat compile
	cp -Rf artifacts counter-app/src/
	sol-merger --remove-comments contracts/Labelless.sol
	mv contracts/Labelless_merged.sol release
	npx hardhat run scripts/deploy-counter-script.js --network localhost

clean:
	rm -f contracts/Labelless_merged.sol
