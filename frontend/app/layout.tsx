import type { Metadata } from "next";
import localFont from "next/font/local";
import { headers } from "next/headers";
import Script from "next/script";
import { cookieToInitialState } from "wagmi";
import "./globals.css";
import { Providers } from "./providers";
import { getConfig } from "./wagmi/config";

const geistSans = localFont({
  src: "./fonts/GeistVF.woff",
  variable: "--font-geist-sans",
  weight: "100 900",
});
const geistMono = localFont({
  src: "./fonts/GeistMonoVF.woff",
  variable: "--font-geist-mono",
  weight: "100 900",
});

export const metadata: Metadata = {
  title: "Omnichain Secret Auctions",
  description: "Omnichain Secret Auctions",
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  const initialState = cookieToInitialState(
    getConfig(),
    headers().get("cookie")
  );

  return (
    <html lang="en">
      <body
        className={`${geistSans.variable} ${geistMono.variable} antialiased`}
      >
        {/*
         * WASM bundling is hard to get right on Next.js, so we just use the prebuilt version:
         * https://github.com/FhenixProtocol/fhenix.js?tab=readme-ov-file#browser-installation-or-simpler-bundling
         */}
        <Script src="https://cdn.jsdelivr.net/npm/fhenixjs@0.4.0/dist/fhenix.umd.min.js" />
        <Providers initialState={initialState}>{children}</Providers>
      </body>
    </html>
  );
}
