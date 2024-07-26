import Selector from "../elements/selector";
import GameManager from "../managers/game";

export default class BuildingSelector extends Phaser.GameObjects.Container {
  protected carved: Phaser.GameObjects.Image;
  protected selector: Selector;
  protected building: Phaser.GameObjects.Image;
  private id: number;
  private index: number;
  private selected: boolean = false;

  constructor(scene: Phaser.Scene, x: number, y: number, id: number, index: number) {
    super(scene, x, y);
    this.id = id;
    this.index = index;

    // Images
    this.carved = new Phaser.GameObjects.Image(scene, 0, 0, "carved-w2-h2");
    const buildingKey = GameManager.getInstance().isBuilt(id) ? `building-house-blue` : `building-house-construction`;
    this.building = new Phaser.GameObjects.Image(scene, 0, -32, buildingKey);

    // Selector
    this.selector = new Selector(scene, 0, 0, 96, 96);
    this.carved.setInteractive().setScrollFactor(0);
    this.carved.on("pointerdown", this.press, this);
    this.carved.on("pointerup", this.release, this);
    this.carved.on("pointerover", this.enter, this);
    this.carved.on("pointerout", this.leave, this);

    // Depths
    this.carved.setDepth(0);
    this.selector.setDepth(1);
    this.building.setDepth(2);

    // Add components to container
    this.add(this.carved);
    this.add(this.selector.setScrollFactor(0));
    this.add(this.building.setScrollFactor(0));
    this.sort('depth');
  }

  update() {
    const buildingId = GameManager.getInstance().getSelectedBuildingId();
    if (!this.selected && this.id === buildingId) {
      this.selector.setForced(true);
      this.selected = true;
    } else if (this.selected && this.id !== buildingId) {
      this.selector.setForced(false);
      this.selected = false;
    }
    this.selector.update();
  }

  press(pointer: Phaser.Input.Pointer, gameObject: Phaser.GameObjects.Image) {
    GameManager.getInstance().setSelectedBuilding(this.id);
    this.selector.press(pointer, gameObject);
  }

  release(pointer: Phaser.Input.Pointer, gameObject: Phaser.GameObjects.Image) {
    this.selector.release(pointer, gameObject);
  }

  enter(pointer: Phaser.Input.Pointer, gameObject: Phaser.GameObjects.Image) {
    this.selector.enter(pointer, gameObject);
  }

  leave(pointer: Phaser.Input.Pointer, gameObject: Phaser.GameObjects.Image) {
    this.selector.leave(pointer, gameObject);
  }
}