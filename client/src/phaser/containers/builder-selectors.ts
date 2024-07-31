import BuilderSelector from "../components/builder-selector";
import GameManager from "../managers/game";

const MAX_ROW_COUNT = 7;

export default class BuilerSelectors extends Phaser.GameObjects.Container {
  protected banners: Phaser.GameObjects.Image[] = [];
  protected selectors: BuilderSelector[] = [];
  protected disabled: boolean = false;
  private cols: number = 0;
  private items: number = 0;

  constructor(scene: Phaser.Scene, x: number, y: number) {
    super(scene, x, y);
    this.setup();
  }

  setup() {
    // Selectors
    this.selectors.forEach((selector) => selector.destroy());
    const workers = GameManager.getInstance().getWorkers();
    this.items = workers.length;
    this.cols = Math.floor((workers.length - 1) / MAX_ROW_COUNT) + 1;
    this.selectors = workers.map((id, index) => {
      const x = 128 * (this.cols - Math.floor(index / MAX_ROW_COUNT)) - 64;
      const y = -384 + (index % MAX_ROW_COUNT) * 128;
      const selector = new BuilderSelector(this.scene, x, y, id);
      selector.setDepth(2);
      selector.setScrollFactor(0);
      return selector;
    });

    // Banners
    this.banners.forEach((selector) => selector.destroy());
    this.banners = [];
    for (let i = 0; i < this.cols; i++) {
      const x = 128 * i;
      const banner = new Phaser.GameObjects.Image(
        this.scene,
        x,
        0,
        "banner-b-w2-h16",
      );
      banner.setOrigin(0, 0.5);
      banner.setDepth(1);
      banner.setInteractive().setScrollFactor(0);
      this.banners.push(banner);
    }
    const x = 128 * this.cols;
    const banner = new Phaser.GameObjects.Image(
      this.scene,
      x,
      0,
      "banner-h-right-w1-h16",
    );
    banner.setOrigin(0, 0.5);
    banner.setDepth(1);
    banner.setInteractive().setScrollFactor(0);
    this.banners.push(banner);

    // Add components to container
    this.banners.forEach((banner) => this.add(banner));
    this.selectors.forEach((selector) => this.add(selector));
    this.sort("depth");
  }

  update() {
    const workers = GameManager.getInstance().getWorkers();
    const cols = Math.floor((workers.length - 1) / MAX_ROW_COUNT) + 1;
    if (this.cols !== cols || this.items !== workers.length) {
      this.setup();
    }
    this.setScale(0.8 ** this.cols);
    this.selectors.forEach((selector) => selector.update());
  }
}
