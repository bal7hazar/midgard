import { EventBus } from "../EventBus";
import { Scene } from "phaser";
import AudioManager from "../managers/audio";
import GameManager from "../managers/game";
import Header from "../containers/header";
import Footer from "../containers/footer";
import { BuilderShop } from "../containers/builder-shop";
import { BuildingShop } from "../containers/building-shop";
import { Construction } from "../containers/construction";
import ActionShop from "../containers/action-shop";
import GoldShop from "../containers/gold-shop";
import { BACKGROUND_HEIGHT, BACKGROUND_WIDTH } from "./Menu";

export class Game extends Scene {
  background: Phaser.GameObjects.TileSprite | null = null;
  header: Header | null = null;
  footer: Footer | null = null;
  builder: BuilderShop | null = null;
  building: BuildingShop | null = null;
  construction: Construction | null = null;
  actionShop: ActionShop | null = null;
  goldShop: GoldShop | null = null;
  modal: Phaser.GameObjects.Rectangle | null = null;

  constructor() {
    super("Game");
  }

  init() {}

  preload() {
    AudioManager.getInstance().addSounds(this);
  }

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

    // Modal
    this.modal = new Phaser.GameObjects.Rectangle(
      this,
      0,
      0,
      this.renderer.width,
      this.renderer.height,
      0x000000,
      0.8,
    );
    this.modal.setOrigin(0, 0);
    this.modal.setInteractive();
    this.modal.setScrollFactor(0, 0);
    this.modal.on("pointerdown", () => EventBus.emit("modal-close"), this);
    this.modal.setDepth(5);
    this.modal.setVisible(false);
    this.add.existing(this.modal);

    // Header Overlay
    this.header = new Header(this, this.renderer.width / 2, 0);
    this.header.setScrollFactor(0, 0);
    this.header.setDepth(1);
    this.add.existing(this.header);

    // Footer Overlay
    this.footer = new Footer(
      this,
      this.renderer.width / 2,
      this.renderer.height,
    );
    this.footer.setScrollFactor(0, 0);
    this.footer.setDepth(2);
    this.add.existing(this.footer);

    // Builder Shop
    this.builder = new BuilderShop(
      this,
      this.renderer.width / 2,
      (this.renderer.height * 2) / 5,
    );
    this.builder.setScrollFactor(0, 0);
    this.builder.setDepth(10);
    this.add.existing(this.builder);

    // Building Pannel
    this.building = new BuildingShop(
      this,
      this.renderer.width / 2,
      (this.renderer.height * 2) / 5,
    );
    this.building.setScrollFactor(0, 0);
    this.building.setDepth(10);
    this.add.existing(this.building);

    // Action shop
    this.actionShop = new ActionShop(
      this,
      this.renderer.width / 2,
      this.renderer.height / 2,
    );
    this.actionShop.setScrollFactor(0, 0);
    this.actionShop.setDepth(10);
    this.add.existing(this.actionShop);

    // Gold shop
    this.goldShop = new GoldShop(
      this,
      this.renderer.width / 2,
      this.renderer.height / 2,
    );
    this.goldShop.setScrollFactor(0, 0);
    this.goldShop.setDepth(10);
    this.add.existing(this.goldShop);

    // Construction
    this.construction = new Construction(
      this,
      this.renderer.width / 2,
      this.renderer.height / 2,
      this.renderer.width,
      this.renderer.height,
    );
    this.construction.setScrollFactor(0, 0);
    this.construction.setDepth(10);
    this.add.existing(this.construction);

    // Listeners
    this.scale.on("resize", this.resize, this);
    EventBus.on("modal-open", () => this.modal?.setVisible(true), this);
    EventBus.on("modal-close", () => this.modal?.setVisible(false), this);

    // Events
    EventBus.emit("current-scene-ready", this);
  }

  update(time: number, delta: number) {
    if (!GameManager.getInstance().game) {
      this.toMenu();
      return;
    } else if (
      !!GameManager.getInstance().game &&
      GameManager.getInstance()?.game?.isOver()
    ) {
      this.toGameOver();
      return;
    }
    if (this.background) {
      this.background.tilePositionX -= 0.1;
    }
    this.header?.update();
    this.footer?.update();
    this.builder?.update();
    this.building?.update();
    this.construction?.update();
    this.actionShop?.update();
    this.goldShop?.update();
  }

  resize(
    gameSize: { width: number; height: number },
    baseSize: number,
    displaySize: number,
    resolution: number,
  ) {
    if (!GameManager.getInstance().game) {
      this.toMenu();
      return;
    } else if (
      !!GameManager.getInstance().game &&
      GameManager.getInstance()?.game?.isOver()
    ) {
      this.toGameOver();
      return;
    }
    // Positions
    const width = gameSize.width;
    const height = gameSize.height;
    this.header?.setPosition(width / 2, 0);
    this.footer?.setPosition(width / 2, height);
    this.builder?.setPosition(width / 2, (height * 2) / 5);
    this.building?.setPosition(width / 2, (height * 2) / 5);
    this.actionShop?.setPosition(width / 2, height / 2);
    this.goldShop?.setPosition(width / 2, height / 2);
    this.construction?.setPosition(width / 2, height / 2);
    this.modal?.setSize(width, height);

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

    // Scales
    if (width > 1024) return;
    const scale = width / 1024;
    this.header?.setScale(scale * 1.5);
    this.footer?.setScale(scale);
    this.builder?.setScale(scale * 1.5);
    this.building?.setScale(scale * 1.5);
  }

  toGameOver() {
    this.scene.start("GameOver");
  }

  toMenu() {
    this.scene.start("Menu");
  }
}
