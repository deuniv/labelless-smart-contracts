all:
	npx hardhat compile
	cp -Rf artifacts counter-app/src/
	sol-merger --remove-comments contracts/Counter.sol
	mv contracts/Counter_merged.sol release

clean:
	rm -f contracts/Counter_merged.sol
