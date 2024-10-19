"use client";

import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select";
import { useFhenixClient } from "@/hooks/useFhenixClient";
import Image from "next/image";
import { useState } from "react";
import { useAccount, useConfig, useConnect, useDisconnect } from "wagmi";
import { getChains } from "wagmi/actions";
import { fhenix } from "./wagmi/fhenix";

export default function Home() {
  const account = useAccount();
  const { connectors, connect, status, error } = useConnect();
  const { disconnect } = useDisconnect();

  const config = useConfig();
  const chains = getChains(config);
  const [selectedChainId, setSelectedChainId] = useState<string>();
  const selectedChain = chains.find(
    (chain) => chain.id === Number(selectedChainId)
  );

  const { fhenixClient, isLoading: isFhenixClientLoading } = useFhenixClient();
  const [bid, setBid] = useState<string>("");

  async function onSubmitEncryptedBid(e: React.FormEvent<HTMLFormElement>) {
    e.preventDefault();

    if (!fhenixClient) {
      return;
    }

    console.log(bid);
    const encryptedBid = await fhenixClient.encrypt_uint256(bid);
    console.log(encryptedBid);
  }

  return (
    <div className="grid grid-rows-[20px_1fr_20px] items-center justify-items-center min-h-screen p-8 pb-20 gap-16 sm:p-20 font-[family-name:var(--font-geist-sans)]">
      <main className="flex flex-col gap-8 row-start-2 items-center sm:items-start lg:w-[50%]">
        <h1 className="text-4xl font-bold">Omnichain Secret Auctions</h1>
        <div className="flex flex-col gap-4 w-full">
          <h2 className="text-2xl font-bold">Auction</h2>
          {account.chain && (
            <p>
              Encrypting on {fhenix.name}, then submitting bid on{" "}
              {selectedChain?.name}.
            </p>
          )}
          <form onSubmit={onSubmitEncryptedBid} className="flex flex-col gap-2">
            <div className="flex flex-row gap-2">
              <Input
                type="number"
                placeholder="Enter your bid"
                value={bid}
                onChange={(e) => setBid(e.target.value)}
                disabled={isFhenixClientLoading}
              />
              <Button type="submit" disabled={isFhenixClientLoading}>
                Submit Encrypted Bid
              </Button>
            </div>
            <small className="text-muted-foreground">
              {isFhenixClientLoading &&
                "Please connect before submitting a bid."}
            </small>
          </form>

          {account.status === "connected" && (
            <Button
              type="button"
              variant="secondary"
              onClick={() => disconnect()}
            >
              Disconnect
            </Button>
          )}
        </div>

        {account.status !== "connected" && (
          <div className="flex flex-col gap-4 w-full">
            <h2 className="text-2xl font-bold">Connect</h2>
            <div className="flex flex-col gap-2">
              <Label>Select a chain</Label>
              <Select
                value={selectedChainId?.toString() ?? ""}
                onValueChange={(value) => setSelectedChainId(value)}
              >
                <SelectTrigger>
                  <SelectValue placeholder="Select a chain" />
                </SelectTrigger>
                <SelectContent>
                  {chains
                    .filter((chain) => chain.id !== fhenix.id)
                    .map((chain) => (
                      <SelectItem key={chain.id} value={chain.id.toString()}>
                        {chain.name}
                      </SelectItem>
                    ))}
                </SelectContent>
              </Select>
              {selectedChain && (
                <small className="text-muted-foreground">
                  Your wallet will first prompt you to connect to{" "}
                  <a
                    href="https://www.fhenix.io/"
                    target="_blank"
                    className="text-black underline underline-offset-4 hover:opacity-50"
                  >
                    Fhenix Helium
                  </a>
                  , where your bid will be encrypted using{" "}
                  <a
                    href="https://docs.fhenix.zone/docs/devdocs/Fhenix%20Testnet/Fhenix-T-FHE#fhe---fully-homomorphic-encryption"
                    target="_blank"
                    className="text-black underline underline-offset-4 hover:opacity-50"
                  >
                    fully homomorphic encryption
                  </a>
                  . Then, your encrypted bid will be submitted on{" "}
                  {selectedChain?.name}.
                </small>
              )}
            </div>
            {selectedChainId && (
              <div className="flex flex-col gap-2 mt-2">
                <Label>Choose a Connector</Label>
                <div className="flex flex-row gap-2">
                  {connectors.map((connector) => (
                    <Button
                      key={connector.uid}
                      onClick={() =>
                        connect({
                          chainId: fhenix.id,
                          connector,
                        })
                      }
                      type="button"
                      disabled={status === "pending"}
                    >
                      {connector.name}
                    </Button>
                  ))}
                </div>
              </div>
            )}
            <div>{error?.message}</div>
          </div>
        )}
      </main>
      <footer className="row-start-3 flex gap-6 flex-wrap items-center justify-center">
        <a
          className="flex items-center gap-2 hover:underline hover:underline-offset-4"
          href="https://github.com/nathanhleung/ethglobal"
          target="_blank"
          rel="noopener noreferrer"
        >
          <Image
            aria-hidden
            src="https://nextjs.org/icons/window.svg"
            alt="Window icon"
            width={16}
            height={16}
          />
          View Source on GitHub
        </a>
      </footer>
    </div>
  );
}
