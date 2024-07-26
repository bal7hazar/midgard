import GameManager from "../managers/game";

export default class Gold extends Phaser.GameObjects.Container {
  protected banner: Phaser.GameObjects.Image;
  protected carved: Phaser.GameObjects.Image;
  protected ribbon: Phaser.GameObjects.Image;
  protected label: Phaser.GameObjects.Text;
  protected title: Phaser.GameObjects.Text;
  protected icon: Phaser.GameObjects.Image;

  constructor(scene: Phaser.Scene, x: number, y: number) {
    super(scene, x, y);

    // Images
    this.banner = new Phaser.GameObjects.Image(scene, 0, 0, "banner-right-w3-h4");
    this.carved = new Phaser.GameObjects.Image(scene, 0, 32, "carved-w1-h1");
    this.ribbon = new Phaser.GameObjects.Image(scene, 32, -32, "ribbon-w4-h1-yellow");
    this.icon = new Phaser.GameObjects.Image(scene, 58, -40, "icon-gold").setDisplaySize(24, 24);

    // Create label
    this.label = new Phaser.GameObjects.Text(scene, 0, 32, '0', {
      fontFamily: "Norse",
      fontSize: 48,
      color: "#ffffff",
      stroke: "#000000",
      strokeThickness: 6,
    }).setOrigin(0.5, 0.5);
    this.title = new Phaser.GameObjects.Text(scene, 0, -40, 'Gold', {
      fontFamily: "Norse",
      fontSize: 36,
      color: "#ffffff",
      stroke: "#000000",
      strokeThickness: 8,
    }).setOrigin(0.5, 0.5);

    // Depths
    this.banner.setDepth(1);
    this.carved.setDepth(2);
    this.ribbon.setDepth(3);
    this.label.setDepth(4);
    this.title.setDepth(5);
    this.icon.setDepth(6);

    // Add components to container
    this.add(this.banner);
    this.add(this.carved);
    this.add(this.ribbon);
    this.add(this.label);
    this.add(this.title);
    this.add(this.icon);
    this.sort('depth')
  }

  update() {
    this.label.setText(`${GameManager.getInstance().game?.gold || 0}`);
  }
}