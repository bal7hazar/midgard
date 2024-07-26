import { Game } from "@/dojo/game/models/game";
import ShopManager from "./shop";
import { BuilderDeck } from "@/dojo/game/types/deck";
import { BuildingDeck } from "@/dojo/game/types/deck";

class GameManager {
  static instance: GameManager;
  public game: Game | null = null;
  public start: () => void = () => {};
  public hire: (builderId: number) => void = () => {};
  public select: (buildingId: number) => void = () => {};
  public send: (builderId: number, buildingId: number) => void = () => {};
  public buy: (quantity: number) => void = () => {};
  private builder: number = 0;
  private building: number = 0;
  private selected: { builder: number, building: number } = { builder: 0, building: 0 };

  constructor() {
    if (GameManager.instance) {
      return GameManager.instance;
    }
    GameManager.instance = this;
  }

  static getInstance() {
    if (!GameManager.instance) {
      GameManager.instance = new GameManager();
    }
    return GameManager.instance;
  }

  setGame(game: Game | null) {
    if (!game) return;
    this.game = game;
    this.builder = game.builders ? game.builders[0] : 0;
    this.building = game.buildings ? game.buildings[0] : 0;
    this.selected = {
      builder: game.workers ? game.workers[0] : 0,
      building: game.constructions ? game.constructions[0] : 0,
    };
    console.log('works', game.works);
  }

  getBuilderId() {
    return this.builder;
  }

  getBuilder() {
    return BuilderDeck.get(this.builder);
  }

  getBuilderIndex() {
    return this.game?.builders.indexOf(this.builder) || 0;
  }

  getWorkerByIndex(index: number) {
    return BuilderDeck.get(this.game?.workers[index] || 0);
  }

  getSelectedBuilderId() {
    return this.selected.builder;
  }

  getSelectedBuilder() {
    return BuilderDeck.get(this.selected.builder);
  }

  getWorkers() {
    return this.game?.workers || [];
  }

  getBuildingId() {
    return this.building;
  }

  getConstructions() {
    return this.game?.constructions || [];
  }

  getBuilding() {
    return BuildingDeck.get(this.building);
  }

  getBuildingIndex() {
    return this.game?.buildings.indexOf(this.building) || 0;
  }

  getSelectedBuildingId() {
    return this.selected.building;
  }

  getSelectedBuilding() {
    return BuildingDeck.get(this.selected.building);
  }

  getBuilderResource(builderId: number) {
    const version = BuilderDeck.getVersion(builderId);
    return BuilderDeck.get(builderId).getResource(version); 
  }

  isBuilt(id: number) {
    return this.game?.structures.includes(id);
  }

  isIdle(id: number) {
    return this.game?.works[id - 1] === 0;
  }

  setBuilding(index: number) {
    if (!this.game) return;
    this.building = this.game.buildings[index] || this.game.buildings[0];
  }

  setBuilder(index: number) {
    if (!this.game) return;
    this.builder = this.game.builders[index] || this.game.builders[0];
  }

  setSelectedBuilding(index: number) {
    this.selected.building = index;
  }

  setSelectedBuilder(index: number) {
    this.selected.builder = index;
  }
  
  setStart(action: () => void) {
    this.start = action;
  }

  setHire(action: (builderId: number) => void) {
    this.hire = action
  }

  setSelect(action: (buildingId: number) => void) {
    this.select = action;
  }

  setSend(action: (builderId: number, buildingId: number) => void) {
    this.send = action;
  }

  setBuy(action: (quantity: number) => void) {
    this.buy = action;
  }

  callStart() {
    if (!this.start || !!this.game) return;
    this.start();
  }

  callHire() {
    if (!this.hire || !this.game) return;
    this.hire(this.getBuilderId());
  }

  callSelect() {
    if (!this.select || !this.game) return;
    this.select(this.getBuildingId());
  }

  callSend() {
    if (!this.send || !this.game) return;
    this.send(this.getSelectedBuilderId(), this.getSelectedBuildingId());
  }

  callBuy() {
    if (!this.buy || !this.game) return;
    this.buy(ShopManager.getInstance().getAction());
  }
}

export default GameManager;
