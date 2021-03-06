/* Autogenerated file. Do not edit manually. */
/* tslint:disable */
/* eslint-disable */

import {
  ethers,
  EventFilter,
  Signer,
  BigNumber,
  BigNumberish,
  PopulatedTransaction,
} from "ethers";
import {
  Contract,
  ContractTransaction,
  Overrides,
  CallOverrides,
} from "@ethersproject/contracts";
import { BytesLike } from "@ethersproject/bytes";
import { Listener, Provider } from "@ethersproject/providers";
import { FunctionFragment, EventFragment, Result } from "@ethersproject/abi";

interface LabellessInterface extends ethers.utils.Interface {
  functions: {
    "createTask(string,string,uint256)": FunctionFragment;
    "distributeAwards(uint256)": FunctionFragment;
    "initilaize(address,address,address,address,address)": FunctionFragment;
    "rejectTask(uint256)": FunctionFragment;
    "reviewTask(uint256)": FunctionFragment;
    "submitTask(uint256,string)": FunctionFragment;
    "takeTask(uint256)": FunctionFragment;
    "verifyTask(uint256)": FunctionFragment;
  };

  encodeFunctionData(
    functionFragment: "createTask",
    values: [string, string, BigNumberish]
  ): string;
  encodeFunctionData(
    functionFragment: "distributeAwards",
    values: [BigNumberish]
  ): string;
  encodeFunctionData(
    functionFragment: "initilaize",
    values: [string, string, string, string, string]
  ): string;
  encodeFunctionData(
    functionFragment: "rejectTask",
    values: [BigNumberish]
  ): string;
  encodeFunctionData(
    functionFragment: "reviewTask",
    values: [BigNumberish]
  ): string;
  encodeFunctionData(
    functionFragment: "submitTask",
    values: [BigNumberish, string]
  ): string;
  encodeFunctionData(
    functionFragment: "takeTask",
    values: [BigNumberish]
  ): string;
  encodeFunctionData(
    functionFragment: "verifyTask",
    values: [BigNumberish]
  ): string;

  decodeFunctionResult(functionFragment: "createTask", data: BytesLike): Result;
  decodeFunctionResult(
    functionFragment: "distributeAwards",
    data: BytesLike
  ): Result;
  decodeFunctionResult(functionFragment: "initilaize", data: BytesLike): Result;
  decodeFunctionResult(functionFragment: "rejectTask", data: BytesLike): Result;
  decodeFunctionResult(functionFragment: "reviewTask", data: BytesLike): Result;
  decodeFunctionResult(functionFragment: "submitTask", data: BytesLike): Result;
  decodeFunctionResult(functionFragment: "takeTask", data: BytesLike): Result;
  decodeFunctionResult(functionFragment: "verifyTask", data: BytesLike): Result;

  events: {};
}

export class Labelless extends Contract {
  connect(signerOrProvider: Signer | Provider | string): this;
  attach(addressOrName: string): this;
  deployed(): Promise<this>;

  on(event: EventFilter | string, listener: Listener): this;
  once(event: EventFilter | string, listener: Listener): this;
  addListener(eventName: EventFilter | string, listener: Listener): this;
  removeAllListeners(eventName: EventFilter | string): this;
  removeListener(eventName: any, listener: Listener): this;

  interface: LabellessInterface;

  functions: {
    createTask(
      taskDetailUri: string,
      name: string,
      amount: BigNumberish,
      overrides?: Overrides
    ): Promise<ContractTransaction>;

    "createTask(string,string,uint256)"(
      taskDetailUri: string,
      name: string,
      amount: BigNumberish,
      overrides?: Overrides
    ): Promise<ContractTransaction>;

    distributeAwards(
      taskId: BigNumberish,
      overrides?: Overrides
    ): Promise<ContractTransaction>;

    "distributeAwards(uint256)"(
      taskId: BigNumberish,
      overrides?: Overrides
    ): Promise<ContractTransaction>;

    initilaize(
      USD: string,
      LLT: string,
      xLLT: string,
      LST: string,
      tasks: string,
      overrides?: Overrides
    ): Promise<ContractTransaction>;

    "initilaize(address,address,address,address,address)"(
      USD: string,
      LLT: string,
      xLLT: string,
      LST: string,
      tasks: string,
      overrides?: Overrides
    ): Promise<ContractTransaction>;

    rejectTask(
      taskId: BigNumberish,
      overrides?: Overrides
    ): Promise<ContractTransaction>;

    "rejectTask(uint256)"(
      taskId: BigNumberish,
      overrides?: Overrides
    ): Promise<ContractTransaction>;

    reviewTask(
      taskId: BigNumberish,
      overrides?: Overrides
    ): Promise<ContractTransaction>;

    "reviewTask(uint256)"(
      taskId: BigNumberish,
      overrides?: Overrides
    ): Promise<ContractTransaction>;

    submitTask(
      taskId: BigNumberish,
      taskResultUrl: string,
      overrides?: Overrides
    ): Promise<ContractTransaction>;

    "submitTask(uint256,string)"(
      taskId: BigNumberish,
      taskResultUrl: string,
      overrides?: Overrides
    ): Promise<ContractTransaction>;

    takeTask(
      taskId: BigNumberish,
      overrides?: Overrides
    ): Promise<ContractTransaction>;

    "takeTask(uint256)"(
      taskId: BigNumberish,
      overrides?: Overrides
    ): Promise<ContractTransaction>;

    verifyTask(
      taskId: BigNumberish,
      overrides?: Overrides
    ): Promise<ContractTransaction>;

    "verifyTask(uint256)"(
      taskId: BigNumberish,
      overrides?: Overrides
    ): Promise<ContractTransaction>;
  };

  createTask(
    taskDetailUri: string,
    name: string,
    amount: BigNumberish,
    overrides?: Overrides
  ): Promise<ContractTransaction>;

  "createTask(string,string,uint256)"(
    taskDetailUri: string,
    name: string,
    amount: BigNumberish,
    overrides?: Overrides
  ): Promise<ContractTransaction>;

  distributeAwards(
    taskId: BigNumberish,
    overrides?: Overrides
  ): Promise<ContractTransaction>;

  "distributeAwards(uint256)"(
    taskId: BigNumberish,
    overrides?: Overrides
  ): Promise<ContractTransaction>;

  initilaize(
    USD: string,
    LLT: string,
    xLLT: string,
    LST: string,
    tasks: string,
    overrides?: Overrides
  ): Promise<ContractTransaction>;

  "initilaize(address,address,address,address,address)"(
    USD: string,
    LLT: string,
    xLLT: string,
    LST: string,
    tasks: string,
    overrides?: Overrides
  ): Promise<ContractTransaction>;

  rejectTask(
    taskId: BigNumberish,
    overrides?: Overrides
  ): Promise<ContractTransaction>;

  "rejectTask(uint256)"(
    taskId: BigNumberish,
    overrides?: Overrides
  ): Promise<ContractTransaction>;

  reviewTask(
    taskId: BigNumberish,
    overrides?: Overrides
  ): Promise<ContractTransaction>;

  "reviewTask(uint256)"(
    taskId: BigNumberish,
    overrides?: Overrides
  ): Promise<ContractTransaction>;

  submitTask(
    taskId: BigNumberish,
    taskResultUrl: string,
    overrides?: Overrides
  ): Promise<ContractTransaction>;

  "submitTask(uint256,string)"(
    taskId: BigNumberish,
    taskResultUrl: string,
    overrides?: Overrides
  ): Promise<ContractTransaction>;

  takeTask(
    taskId: BigNumberish,
    overrides?: Overrides
  ): Promise<ContractTransaction>;

  "takeTask(uint256)"(
    taskId: BigNumberish,
    overrides?: Overrides
  ): Promise<ContractTransaction>;

  verifyTask(
    taskId: BigNumberish,
    overrides?: Overrides
  ): Promise<ContractTransaction>;

  "verifyTask(uint256)"(
    taskId: BigNumberish,
    overrides?: Overrides
  ): Promise<ContractTransaction>;

  callStatic: {
    createTask(
      taskDetailUri: string,
      name: string,
      amount: BigNumberish,
      overrides?: CallOverrides
    ): Promise<void>;

    "createTask(string,string,uint256)"(
      taskDetailUri: string,
      name: string,
      amount: BigNumberish,
      overrides?: CallOverrides
    ): Promise<void>;

    distributeAwards(
      taskId: BigNumberish,
      overrides?: CallOverrides
    ): Promise<void>;

    "distributeAwards(uint256)"(
      taskId: BigNumberish,
      overrides?: CallOverrides
    ): Promise<void>;

    initilaize(
      USD: string,
      LLT: string,
      xLLT: string,
      LST: string,
      tasks: string,
      overrides?: CallOverrides
    ): Promise<void>;

    "initilaize(address,address,address,address,address)"(
      USD: string,
      LLT: string,
      xLLT: string,
      LST: string,
      tasks: string,
      overrides?: CallOverrides
    ): Promise<void>;

    rejectTask(taskId: BigNumberish, overrides?: CallOverrides): Promise<void>;

    "rejectTask(uint256)"(
      taskId: BigNumberish,
      overrides?: CallOverrides
    ): Promise<void>;

    reviewTask(taskId: BigNumberish, overrides?: CallOverrides): Promise<void>;

    "reviewTask(uint256)"(
      taskId: BigNumberish,
      overrides?: CallOverrides
    ): Promise<void>;

    submitTask(
      taskId: BigNumberish,
      taskResultUrl: string,
      overrides?: CallOverrides
    ): Promise<void>;

    "submitTask(uint256,string)"(
      taskId: BigNumberish,
      taskResultUrl: string,
      overrides?: CallOverrides
    ): Promise<void>;

    takeTask(taskId: BigNumberish, overrides?: CallOverrides): Promise<void>;

    "takeTask(uint256)"(
      taskId: BigNumberish,
      overrides?: CallOverrides
    ): Promise<void>;

    verifyTask(taskId: BigNumberish, overrides?: CallOverrides): Promise<void>;

    "verifyTask(uint256)"(
      taskId: BigNumberish,
      overrides?: CallOverrides
    ): Promise<void>;
  };

  filters: {};

  estimateGas: {
    createTask(
      taskDetailUri: string,
      name: string,
      amount: BigNumberish,
      overrides?: Overrides
    ): Promise<BigNumber>;

    "createTask(string,string,uint256)"(
      taskDetailUri: string,
      name: string,
      amount: BigNumberish,
      overrides?: Overrides
    ): Promise<BigNumber>;

    distributeAwards(
      taskId: BigNumberish,
      overrides?: Overrides
    ): Promise<BigNumber>;

    "distributeAwards(uint256)"(
      taskId: BigNumberish,
      overrides?: Overrides
    ): Promise<BigNumber>;

    initilaize(
      USD: string,
      LLT: string,
      xLLT: string,
      LST: string,
      tasks: string,
      overrides?: Overrides
    ): Promise<BigNumber>;

    "initilaize(address,address,address,address,address)"(
      USD: string,
      LLT: string,
      xLLT: string,
      LST: string,
      tasks: string,
      overrides?: Overrides
    ): Promise<BigNumber>;

    rejectTask(taskId: BigNumberish, overrides?: Overrides): Promise<BigNumber>;

    "rejectTask(uint256)"(
      taskId: BigNumberish,
      overrides?: Overrides
    ): Promise<BigNumber>;

    reviewTask(taskId: BigNumberish, overrides?: Overrides): Promise<BigNumber>;

    "reviewTask(uint256)"(
      taskId: BigNumberish,
      overrides?: Overrides
    ): Promise<BigNumber>;

    submitTask(
      taskId: BigNumberish,
      taskResultUrl: string,
      overrides?: Overrides
    ): Promise<BigNumber>;

    "submitTask(uint256,string)"(
      taskId: BigNumberish,
      taskResultUrl: string,
      overrides?: Overrides
    ): Promise<BigNumber>;

    takeTask(taskId: BigNumberish, overrides?: Overrides): Promise<BigNumber>;

    "takeTask(uint256)"(
      taskId: BigNumberish,
      overrides?: Overrides
    ): Promise<BigNumber>;

    verifyTask(taskId: BigNumberish, overrides?: Overrides): Promise<BigNumber>;

    "verifyTask(uint256)"(
      taskId: BigNumberish,
      overrides?: Overrides
    ): Promise<BigNumber>;
  };

  populateTransaction: {
    createTask(
      taskDetailUri: string,
      name: string,
      amount: BigNumberish,
      overrides?: Overrides
    ): Promise<PopulatedTransaction>;

    "createTask(string,string,uint256)"(
      taskDetailUri: string,
      name: string,
      amount: BigNumberish,
      overrides?: Overrides
    ): Promise<PopulatedTransaction>;

    distributeAwards(
      taskId: BigNumberish,
      overrides?: Overrides
    ): Promise<PopulatedTransaction>;

    "distributeAwards(uint256)"(
      taskId: BigNumberish,
      overrides?: Overrides
    ): Promise<PopulatedTransaction>;

    initilaize(
      USD: string,
      LLT: string,
      xLLT: string,
      LST: string,
      tasks: string,
      overrides?: Overrides
    ): Promise<PopulatedTransaction>;

    "initilaize(address,address,address,address,address)"(
      USD: string,
      LLT: string,
      xLLT: string,
      LST: string,
      tasks: string,
      overrides?: Overrides
    ): Promise<PopulatedTransaction>;

    rejectTask(
      taskId: BigNumberish,
      overrides?: Overrides
    ): Promise<PopulatedTransaction>;

    "rejectTask(uint256)"(
      taskId: BigNumberish,
      overrides?: Overrides
    ): Promise<PopulatedTransaction>;

    reviewTask(
      taskId: BigNumberish,
      overrides?: Overrides
    ): Promise<PopulatedTransaction>;

    "reviewTask(uint256)"(
      taskId: BigNumberish,
      overrides?: Overrides
    ): Promise<PopulatedTransaction>;

    submitTask(
      taskId: BigNumberish,
      taskResultUrl: string,
      overrides?: Overrides
    ): Promise<PopulatedTransaction>;

    "submitTask(uint256,string)"(
      taskId: BigNumberish,
      taskResultUrl: string,
      overrides?: Overrides
    ): Promise<PopulatedTransaction>;

    takeTask(
      taskId: BigNumberish,
      overrides?: Overrides
    ): Promise<PopulatedTransaction>;

    "takeTask(uint256)"(
      taskId: BigNumberish,
      overrides?: Overrides
    ): Promise<PopulatedTransaction>;

    verifyTask(
      taskId: BigNumberish,
      overrides?: Overrides
    ): Promise<PopulatedTransaction>;

    "verifyTask(uint256)"(
      taskId: BigNumberish,
      overrides?: Overrides
    ): Promise<PopulatedTransaction>;
  };
}
