import { defineChain } from 'viem'

export const fhenix = defineChain({
  id: 8008135,
  name: 'Fhenix Helium',
  nativeCurrency: { name: 'tFHE', symbol: 'tFHE', decimals: 18 },
  rpcUrls: {
    default: { http: ['https://api.helium.fhenix.zone'] },
  },
  blockExplorers: {
    default: { name: 'Fhenix explorer', url: 'https://explorer.helium.fhenix.zone/' },
  },
})