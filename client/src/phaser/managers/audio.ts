import Phaser from "phaser";

class AudioManager {
  static instance: AudioManager;

  constructor() {
    if (AudioManager.instance) {
      return AudioManager.instance;
    }
    AudioManager.instance = this;
  }

  static getInstance() {
    if (!AudioManager.instance) {
      AudioManager.instance = new AudioManager();
    }
    return AudioManager.instance;
  }

  static play(scene: Phaser.Scene, key: string, loop: boolean = false) {
    if (scene) {
      if (loop) {
        scene.sound.play(key, { loop: true });
        return;
      } else {
        scene.sound.play(key);
      }
    }
  }

  addSounds(scene: Phaser.Scene) {
    // Themes
    scene.sound.add("theme-menu");
    // Effects
    scene.sound.add("action-select");
    scene.sound.add("button-hover");
    scene.sound.add("button-click");
  }
}

export default AudioManager;
