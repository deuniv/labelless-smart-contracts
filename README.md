# Labelless


## One Step Building
```
make
```

## Deploy to Local Dev
```
npx hardhat node
truffle build
truffle deploy
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