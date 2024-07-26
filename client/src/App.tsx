import { useRef } from "react";

import { PhaserGame } from "@/phaser/PhaserGame";
import { useActions } from "./hooks/useActions";

function App() {
  const phaserRef = useRef(null);
  useActions();

  return (
    <div id="app" className="flex flex-col items-center">
      <div className="text-4xl font-bold">Midgard</div>
      <PhaserGame ref={phaserRef} currentActiveScene={undefined} />
    </div>
  );
}

export default App;
