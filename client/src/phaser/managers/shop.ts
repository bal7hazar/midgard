import GameManager from "./game";

class ShopManager {
  static instance: ShopManager;
  private gold: number = 5;
  private action: number = 1;
  private step: number = 5;

  constructor() {
    if (ShopManager.instance) {
      return ShopManager.instance;
    }
    ShopManager.instance = this;
  }

  static getInstance() {
    if (!ShopManager.instance) {
      ShopManager.instance = new ShopManager();
    }
    return ShopManager.instance;
  }

  getGold() {
    return this.gold;
  }

  getAction() {
    return this.action;
  }

  getStep() {
    return this.step;
  }

  increase() {
    const gold = GameManager.getInstance().game?.gold || 0;
    if (this.gold + this.step > gold) return;
    this.gold += this.step;
    this.action += 1;
  }

  decrease() {
    if (this.gold <= this.step) return;
    this.gold -= this.step;
    this.action -= 1;
  }

  canIncrease() {
    return this.gold + this.step <= (GameManager.getInstance().game?.gold || 0);
  }

  canDecrease() {
    return this.gold > this.step;
  }

  canPerform() {
    const gold = GameManager.getInstance().game?.gold || 0;
    return this.action > 0 && gold >= this.gold;
  }
}

export default ShopManager;
