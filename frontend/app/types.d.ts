import { fhenixjs } from "fhenixjs";

declare global {
  interface Window {
    // From `script` tag in `layout.tsx`
    fhenixjs: {
      fhenixjs: fhenixjs;
    };
  }
}
