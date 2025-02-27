import { Boot } from "./scenes/Boot";
import { Game } from "./scenes/Game";
import { GameOver } from "./scenes/GameOver";
import { Menu } from "./scenes/Menu";
import Phaser from "phaser";
import { Preloader } from "./scenes/Preloader";
import RexUIPlugin from "phaser3-rex-plugins/templates/ui/ui-plugin";

export const app = {
  width: 0,
  height: 0,
};

const config = {
  parent: "game-container",
  dom: {
    createContainer: true,
  },
  backgroundColor: 0xeeeeee,
  banner: false,
  type: Phaser.AUTO,
  antialias: true,
  disableContextMenu: true,
  autoMobilePipeline: true,
  autoRound: true,
  scene: [Boot, Preloader, Menu, Game, GameOver],
  scale: {
    mode: Phaser.Scale.RESIZE,
    parent: "phaser-example",
    width: "100%",
    height: "100%",
    min: {
      width: 344,
      height: 300,
    },
    max: {
      width: 1920,
      height: 816,
    },
  },
  plugins: {
    scene: [
      {
        key: "rexUI",
        plugin: RexUIPlugin,
        mapping: "rexUI",
      },
    ],
  },
};

const StartGame = (parent: string) => {
  return new Phaser.Game({ ...config, parent });
};

export default StartGame;
