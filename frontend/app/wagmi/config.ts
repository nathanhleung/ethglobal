import { http, cookieStorage, createConfig, createStorage } from "wagmi";
import {
  arbitrumSepolia,
  flowTestnet,
  polygonAmoy,
  sepolia,
  storyTestnet,
  unichainSepolia,
  skaleCalypsoTestnet,
  hederaTestnet,
  zircuitTestnet,
  morphSepolia,
} from "wagmi/chains";
import { fhenix } from "./fhenix";
import { injected, walletConnect } from "wagmi/connectors";

export function getConfig() {
  return createConfig({
    chains: [
      sepolia,
      arbitrumSepolia,
      storyTestnet,
      polygonAmoy,
      flowTestnet,
      unichainSepolia,
      skaleCalypsoTestnet,
      hederaTestnet,
      zircuitTestnet,
      morphSepolia,
      fhenix,
    ],
    connectors: [
      injected(),
      walletConnect({ projectId: process.env.NEXT_PUBLIC_WC_PROJECT_ID! }),
    ],
    storage: createStorage({
      storage: cookieStorage,
    }),
    ssr: true,
    transports: {
      [sepolia.id]: http(),
      [arbitrumSepolia.id]: http(),
      [storyTestnet.id]: http(),
      [polygonAmoy.id]: http(),
      [flowTestnet.id]: http(),
      [unichainSepolia.id]: http(),
      [skaleCalypsoTestnet.id]: http(),
      [hederaTestnet.id]: http(),
      [zircuitTestnet.id]: http(),
      [morphSepolia.id]: http(),
      [fhenix.id]: http(),
    },
  });
}

declare module "wagmi" {
  interface Register {
    config: ReturnType<typeof getConfig>;
  }
}
