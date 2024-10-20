import { fhenix } from "@/app/wagmi/fhenix";
import type { FhenixClient } from "fhenixjs";
import { useEffect, useState } from "react";
import { useAccount } from "wagmi";

function useFhenixClient() {
  const account = useAccount();

  const [fhenixClient, setFhenixClient] = useState<FhenixClient | null>(null);
  useEffect(() => {
    if (account.connector?.getProvider) {
      account.connector
        .getProvider({
          chainId: fhenix.id,
        })
        .then((provider) => {
          return new window.fhenixjs.fhenixjs.FhenixClient({ provider });
        })
        .then((fhenixClient) => {
          setFhenixClient(fhenixClient);
        });
    } else {
      setFhenixClient(null);
    }
  }, [account]);

  return { fhenixClient, isLoading: !fhenixClient };
}

export { useFhenixClient };
