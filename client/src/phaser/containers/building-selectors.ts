import BuildingSelector from "../components/building-selector";
import GameManager from "../managers/game";

export default class BuildingSelectors extends Phaser.GameObjects.Container {
  protected banners: Phaser.GameObjects.Image[];
  protected selectors: BuildingSelector[];
  protected disabled: boolean = false;

  constructor(scene: Phaser.Scene, x: number, y: number) {
    super(scene, x, y);

    // Images
    this.banners = [
      new Phaser.GameObjects.Image(scene, 0, 0, "banner-h-left-w1-h16"),
      new Phaser.GameObjects.Image(scene, 96, 0, "banner-b-w2-h16"),
    ];

    // Selector
    const constructions = GameManager.getInstance().getConstructions();
    this.selectors = constructions.map((id, index) => {
      const y = -384 + (index * 128);
      return new BuildingSelector(scene, 96, y, id, index);
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
    const constructions = GameManager.getInstance().getConstructions();
    if (this.selectors.length !== constructions.length) {
      this.selectors.forEach(selector => selector.destroy());
      this.selectors = constructions.map((id, index) => {
        const y = -384 + (index * 128);
        return new BuildingSelector(this.scene, 96, y, id, index);
      });
      this.selectors.forEach(selector => selector.setDepth(2));
      this.selectors.forEach(selector => this.add(selector.setScrollFactor(0)));
      this.sort('depth');
    }
    this.selectors.forEach(selector => selector.update());
  }
}