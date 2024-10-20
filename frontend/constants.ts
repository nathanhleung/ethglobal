import { anvil, arbitrumSepolia, polygonAmoy } from "viem/chains";

export const BIDDER_CONTRACT_ADDRESSES: Record<string, `0x${string}`> = {
    [anvil.id]: "0x7ce31b38D8f3b76de9D616A8f223Eb13e17A52A6",
    [polygonAmoy.id]: "0x73312E44D22e3c629337672902CD380773f27e87",
    [arbitrumSepolia.id]: "0xd2232d2F79b51f5da79ea3DF2d37B3435073bFB6",
}