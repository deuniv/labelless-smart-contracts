# Labelless


## One Step Building
```
make
```

## Deploy to Local Dev
```
npx hardhat node
npx hardhat run scripts/deploy-counter-script.js --network localhost
```

## Run Frontend App
```
cd counter-app
yarn install
yarn start
```

## Individual Steps

Re-Generating types for contracts

```
npx hardhat compile
```



#### Manual Deployment

```
sol-merger --remove-comments contracts/Counter.sol
```