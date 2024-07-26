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
import { BACKGROUND_HEIGHT, BACKGROUND_WIDTH } from "./Menu";

const SIZE = 2048;

export class Game extends Scene {
  background: Phaser.GameObjects.TileSprite | null = null;
  map: Phaser.Tilemaps.Tilemap | null = null;
  animatedTiles: any = undefined;
  header: Header | null = null;
  footer: Footer | null = null;
  builder: BuilderShop | null = null;
  building: BuildingShop | null = null;
  construction: Construction | null = null;
  shop: ActionShop | null = null;
  modal: Phaser.GameObjects.Rectangle | null = null;

  constructor() {
    super("Game");
  }

  init() {}

  preload() {
    this.load.scenePlugin('AnimatedTiles', 'https://raw.githubusercontent.com/nkholski/phaser-animated-tiles/master/dist/AnimatedTiles.js', 'animatedTiles', 'animatedTiles');   
    this.load.image("tiles", "assets/Tilemaps/tilemap.png");
    this.load.tilemapTiledJSON("tilemap", "assets/Tilemaps/tilemap.json");
    AudioManager.getInstance().addSounds(this);
  }

  create() {
    AudioManager.play(this, "theme-menu", true);

    // Camera
    // const cam = this.cameras.main;
    // cam.setZoom(0.5);

    // // Load map
    // this.map = this.make.tilemap({ key: "tilemap", width: this.renderer.width, height: this.renderer.height });
    // const tileset = this.map.addTilesetImage("tilemap", "tiles");
    // this.map.createLayer("Water", tileset!);
    // this.map.createLayer("Foams-L-0", tileset!);
    // this.map.createLayer("Foams-R-0", tileset!);
    // this.map.createLayer("Foams-U-0", tileset!);
    // this.map.createLayer("Foams-D-0", tileset!);
    // this.map.createLayer("Beach", tileset!);
    // this.map.createLayer("Shadow-L-0", tileset!);
    // this.map.createLayer("Shadow-R-0", tileset!);
    // this.map.createLayer("Shadow-D-0", tileset!);
    // this.map.createLayer("Elevation-0", tileset!);
    // this.map.createLayer("Ground-0", tileset!);
    // this.map.createLayer("Bridges-0", tileset!);
    // this.map.createLayer("Shadow-L-1", tileset!);
    // this.map.createLayer("Shadow-R-1", tileset!);
    // this.map.createLayer("Shadow-D-1", tileset!);
    // this.map.createLayer("Elevation-1", tileset!);
    // this.map.createLayer("Ground-1", tileset!);
    // this.map.createLayer("Shadow-L-2", tileset!);
    // this.map.createLayer("Shadow-R-2", tileset!);
    // this.map.createLayer("Shadow-D-2", tileset!);
    // this.map.createLayer("Elevation-2", tileset!);
    // this.map.createLayer("Ground-2", tileset!);
    // this.map.createLayer("Bridges-2", tileset!);
    // this.animatedTiles.init(this.map);

    this.background = this.add.tileSprite(
      this.renderer.width / 2,
      this.renderer.height / 2,
      this.renderer.width,
      this.renderer.height,
      "menu-bg"
    ).setOrigin(0.5, 0.5);
    this.background.setTilePosition(0, 0);
    if (this.background.width * BACKGROUND_HEIGHT / BACKGROUND_WIDTH < this.background.height) {
      this.background.setSize(this.background.height * BACKGROUND_WIDTH/BACKGROUND_HEIGHT, this.background.height);
    } else {
      this.background.setSize(this.background.width, this.background.width * BACKGROUND_HEIGHT / BACKGROUND_WIDTH);
    }
    this.background.alpha = 0.3;

    // Modal
    this.modal = new Phaser.GameObjects.Rectangle(this, 0, 0, this.renderer.width, this.renderer.height, 0x000000, 0.8);
    this.modal.setOrigin(0, 0);
    this.modal.setInteractive();
    this.modal.setScrollFactor(0, 0);
    this.modal.on("pointerdown", () => EventBus.emit("modal-close"), this);
    this.modal.setDepth(5);
    this.modal.setVisible(false);
    this.add.existing(this.modal);

    // Header Overlay
    this.header = new Header(this, this.renderer.width / 2, 0);
    this.header.setPosition(this.header.x, this.header.y + this.header.getBounds().height / 2);
    this.header.setScrollFactor(0, 0);
    this.header.setDepth(1);
    this.add.existing(this.header);

    // Footer Overlay
    this.footer = new Footer(this, this.renderer.width / 2, this.renderer.height);
    this.footer.setPosition(this.footer.x, this.footer.y - this.footer.getBounds().height / 2);
    this.footer.setScrollFactor(0, 0);
    this.footer.setDepth(2);
    this.add.existing(this.footer);

    // Builder Shop
    this.builder = new BuilderShop(this, this.renderer.width / 2, this.renderer.height / 3);
    this.builder.setScrollFactor(0, 0);
    this.builder.setDepth(10);
    this.add.existing(this.builder);

    // Building Pannel
    this.building = new BuildingShop(this, this.renderer.width / 2, this.renderer.height / 3);
    this.building.setScrollFactor(0, 0);
    this.building.setDepth(10);
    this.add.existing(this.building);

    // Action shop
    this.shop = new ActionShop(this, this.renderer.width / 2, this.renderer.height / 2);
    this.shop.setScrollFactor(0, 0);
    this.shop.setDepth(10);
    this.add.existing(this.shop);

    // Construction
    this.construction = new Construction(this, this.renderer.width / 2, this.renderer.height / 2, this.renderer.width, this.renderer.height);
    this.construction.setScrollFactor(0, 0);
    this.construction.setDepth(10);
    this.add.existing(this.construction);

    // Listeners
    this.scale.on('resize', this.resize, this);
    EventBus.on("modal-open", () => this.modal?.setVisible(true), this);
    EventBus.on("modal-close", () => this.modal?.setVisible(false), this);

    // Events
    EventBus.emit("current-scene-ready", this);
  }

  update(time: number, delta: number) {
    if (this.background) {
      this.background.tilePositionX -= 0.1;
    }
    this.header?.update();
    this.footer?.update();
    this.builder?.update();
    this.building?.update();
    this.construction?.update();
    this.shop?.update();
    if (!!GameManager.getInstance().game && GameManager.getInstance()?.game?.isOver()) {
      this.changeScene();
    }
  }

  resize(gameSize: { width: number, height: number }, baseSize: number, displaySize: number, resolution: number) {
    const width = gameSize.width;
    const height = gameSize.height;
    this.header?.setPosition(width / 2, this.header.getBounds().height / 2);
    this.footer?.setPosition(width / 2, height - this.footer.getBounds().height / 2);
    this.builder?.setPosition(width / 2, height / 3);
    this.building?.setPosition(width / 2, height / 3);
    this.shop?.setPosition(width / 2, height / 2);
    this.construction?.setPosition(width / 2, height / 2);
    this.modal?.setSize(width, height);

    // Background
    if (width * BACKGROUND_HEIGHT / BACKGROUND_WIDTH < height) {
      this.background?.setSize(height * BACKGROUND_WIDTH/BACKGROUND_HEIGHT, height);
    } else {
      this.background?.setSize(width, width * BACKGROUND_HEIGHT / BACKGROUND_WIDTH);
    }
    this.background?.setPosition(width / 2, height / 2);
  }

  changeScene() {
    this.scene.start("GameOver");
  }
}