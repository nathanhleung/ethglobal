import type { FhenixClient } from "fhenixjs";
import { useEffect, useState } from "react";
import { useAccount } from "wagmi";

function useFhenixClient() {
  const account = useAccount();

  const [fhenixClient, setFhenixClient] = useState<FhenixClient | null>(null);
  useEffect(() => {
    if (account.connector?.getProvider) {
      account.connector.getProvider().then((provider) => {
        setFhenixClient(
          new window.fhenixjs.fhenixjs.FhenixClient({ provider })
        );
      });
    } else {
      setFhenixClient(null);
    }
  }, [account]);

  return { fhenixClient, isLoading: !fhenixClient };
}

export { useFhenixClient };

