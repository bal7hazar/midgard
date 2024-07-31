import { EventBus } from "../EventBus";
import { Scene } from "phaser";
import AnimationManager from "../managers/animation";
import Start from "../actions/start";
import Credits from "../actions/credits";
import Create from "../components/create";
import AudioManager from "../managers/audio";
import GameManager from "../managers/game";

export const BACKGROUND_HEIGHT = 816;
export const BACKGROUND_WIDTH = 2892;

export class Menu extends Scene {
  title: Phaser.GameObjects.Text | null = null;
  label: Phaser.GameObjects.Text | null = null;
  pawnLeft: Phaser.GameObjects.Sprite | null = null;
  pawnRight: Phaser.GameObjects.Sprite | null = null;
  background: Phaser.GameObjects.TileSprite | null = null;
  signup: Phaser.GameObjects.Container | null = null;
  start: Phaser.GameObjects.Container | null = null;
  credits: Phaser.GameObjects.Container | null = null;

  constructor() {
    super("Menu");
  }

  init() {}

  preload() {}

  create() {
    this.background = this.add
      .tileSprite(
        this.renderer.width / 2,
        this.renderer.height / 2,
        this.renderer.width,
        this.renderer.height,
        "menu-bg",
      )
      .setOrigin(0.5, 0.5);
    this.background.setTilePosition(0, 0);
    if (
      (this.background.width * BACKGROUND_HEIGHT) / BACKGROUND_WIDTH <
      this.background.height
    ) {
      this.background.setSize(
        (this.background.height * BACKGROUND_WIDTH) / BACKGROUND_HEIGHT,
        this.background.height,
      );
    } else {
      this.background.setSize(
        this.background.width,
        (this.background.width * BACKGROUND_HEIGHT) / BACKGROUND_WIDTH,
      );
    }
    this.background.alpha = 0.3;

    this.title = this.add
      .text(this.renderer.width / 2, this.renderer.height / 3, "Miðgarð", {
        fontFamily: "Norse",
        fontSize: 120,
        color: "#ffffff",
        stroke: "#000000",
        strokeThickness: 8,
        align: "center",
      })
      .setOrigin(0.5);

    this.pawnLeft = this.add.sprite(
      this.renderer.width / 2 - 128,
      this.renderer.height / 2,
      "pawn-red",
    );
    this.pawnLeft.play("pawn-red-hit");

    this.pawnRight = this.add.sprite(
      this.renderer.width / 2 + 128,
      this.renderer.height / 2,
      "pawn-blue",
    );
    this.pawnRight.flipX = true;
    this.pawnRight.play("pawn-blue-hit");

    this.label = this.add
      .text(this.renderer.width / 2, this.renderer.height / 2, "Main Menu", {
        fontFamily: "Norse",
        fontSize: 38,
        color: "#ffffff",
        stroke: "#000000",
        strokeThickness: 4,
        align: "center",
      })
      .setOrigin(0.5);

    this.signup = new Create(
      this,
      this.renderer.width / 2,
      this.renderer.height / 2 + 100,
    );
    this.add.existing(this.signup);

    this.start = new Start(
      this,
      this.renderer.width / 2,
      this.renderer.height / 2 + 100,
    );
    this.add.existing(this.start);

    this.credits = new Credits(
      this,
      this.renderer.width / 2,
      this.renderer.height / 2 + 175,
    );
    this.add.existing(this.credits);

    this.scale.on("resize", this.resize, this);
    EventBus.emit("current-scene-ready", this);
  }

  update() {
    if (this.background) {
      this.background.tilePositionX -= 0.1;
    }
    this.signup?.update();
    this.start?.update();
    this.credits?.update();

    if (!!GameManager.getInstance().game) {
      this.changeScene();
    }
  }

  resize(
    gameSize: { width: number; height: number },
    baseSize: number,
    displaySize: number,
    resolution: number,
  ) {
    const width = gameSize.width;
    const height = gameSize.height;
    this.title?.setPosition(width / 2, height / 3);
    this.label?.setPosition(width / 2, height / 2);
    this.pawnLeft?.setPosition(width / 2 - 128, height / 2);
    this.pawnRight?.setPosition(width / 2 + 128, height / 2);
    this.signup?.setPosition(width / 2, height / 2 + 100);
    this.start?.setPosition(width / 2, height / 2 + 100);
    this.credits?.setPosition(width / 2, height / 2 + 175);

    // Background
    if ((width * BACKGROUND_HEIGHT) / BACKGROUND_WIDTH < height) {
      this.background?.setSize(
        (height * BACKGROUND_WIDTH) / BACKGROUND_HEIGHT,
        height,
      );
    } else {
      this.background?.setSize(
        width,
        (width * BACKGROUND_HEIGHT) / BACKGROUND_WIDTH,
      );
    }
    this.background?.setPosition(width / 2, height / 2);
  }

  changeScene() {
    this.scene.start("Game");
  }
}
