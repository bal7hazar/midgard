import Start from "../actions/start";
import { EventBus } from "../EventBus";
import { Scene } from "phaser";
import GameManager from "../managers/game";

export class GameOver extends Scene {
  start: Phaser.GameObjects.Container | null = null;

  constructor() {
    super("GameOver");
  }

  create() {
    this.add
      .text(this.renderer.width / 2, this.renderer.height / 2, "Game Over", {
        fontFamily: "Norse",
        fontSize: 64,
        color: "#ffffff",
        stroke: "#000000",
        strokeThickness: 8,
        align: "center",
      })
      .setOrigin(0.5, 0.5)
      .setDepth(100);

    this.start = new Start(
      this,
      this.renderer.width / 2,
      this.renderer.height / 2 + 100,
    );
    this.add.existing(this.start);

    EventBus.emit("current-scene-ready", this);
  }

  update() {
    if (!GameManager.getInstance().game) {
      this.toMenu();
    } else if (
      !!GameManager.getInstance().game &&
      !GameManager.getInstance()?.game?.isOver()
    ) {
      this.toGame();
    }
    this.start?.update();
  }

  toGame() {
    this.scene.start("Game");
  }

  toMenu() {
    this.scene.start("Menu");
  }
}
