import BuilderSelector from "../components/builder-selector";
import GameManager from "../managers/game";

export default class BuilerSelectors extends Phaser.GameObjects.Container {
  protected banners: Phaser.GameObjects.Image[];
  protected selectors: BuilderSelector[];
  protected disabled: boolean = false;

  constructor(scene: Phaser.Scene, x: number, y: number) {
    super(scene, x, y);

    // Images
    this.banners = [
      new Phaser.GameObjects.Image(scene, 0, 0, "banner-h-right-w1-h16"),
      new Phaser.GameObjects.Image(scene, -96, 0, "banner-b-w2-h16"),
    ];

    // Selector
    const workers = GameManager.getInstance().getWorkers();
    this.selectors = workers.map((id, index) => {
      const y = -384 + (index * 128);
      return new BuilderSelector(scene, -96, y, id, index);
    });
      
    // Depths
    this.banners.forEach(banner => banner.setDepth(1));
    this.selectors.forEach(selector => selector.setDepth(2));

    // Prevent click through
    this.banners.forEach(banner => banner.setInteractive().setScrollFactor(0));

    // Add components to container
    this.banners.forEach(banner => this.add(banner));
    this.selectors.forEach(selector => this.add(selector.setScrollFactor(0)));
    this.sort('depth');
  }

  update() {
    const workers = GameManager.getInstance().getWorkers();
    if (this.selectors.length !== workers.length) {
      this.selectors.forEach(selector => selector.destroy());
      this.selectors = workers.map((id, index) => {
        const y = -384 + (index * 128);
        return new BuilderSelector(this.scene, -96, y, id, index);
      });
      this.selectors.forEach(selector => selector.setDepth(2));
      this.selectors.forEach(selector => this.add(selector.setScrollFactor(0)));
      this.sort('depth');
    }
    this.selectors.forEach(selector => selector.update());
  }
}