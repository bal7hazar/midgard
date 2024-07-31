import { Scene } from "phaser";
import AudioManager from "../managers/audio";
import AnimationManager from "../managers/animation";

export class Preloader extends Scene {
  constructor() {
    super("Preloader");
  }

  init() {
    //  We loaded this image in our Boot Scene, so we can display it here
    this.add.image(512, 384, "loading");

    //  A simple progress bar. This is the outline of the bar.
    this.add.rectangle(512, 384, 468, 32).setStrokeStyle(1, 0xffffff);

    //  This is the progress bar itself. It will increase in size from the left based on the % of progress.
    const bar = this.add.rectangle(512 - 230, 384, 4, 28, 0xffffff);

    //  Use the 'progress' event emitted by the LoaderPlugin to update the loading bar
    this.load.on("progress", (progress: number) => {
      //  Update the progress bar (our bar is 464px wide, so 100% = 464px)
      bar.width = 4 + 460 * progress;
    });
  }

  preload() {
    // Sound themes
    this.load.audio(
      "theme-menu",
      "sounds/themes/alexander-nakarada-folkvangr.mp3",
    );
    this.load.audio(
      "theme-game-2",
      "sounds/themes/alexander-nakarada-tavern-loop-one.mp3",
    );
    this.load.audio(
      "theme-game-3",
      "sounds/themes/alexander-nakarada-war-shout-loop-ready.mp3",
    );

    // Sound effects
    this.load.audio("action-select", "sounds/effects/build.mp3");
    this.load.audio("button-hover", "sounds/effects/hover.wav");
    this.load.audio("button-click", "sounds/effects/click.wav");

    // Backgrounds
    this.load.image("menu-bg", "assets/Themes/menu.png");

    // Pointers
    this.load.image("pointer", "assets/UI/Pointers/01.png");
    this.load.image("selector", "assets/UI/Pointers/02.png");
    this.load.image("selector-nw", "assets/UI/Pointers/03.png");
    this.load.image("selector-ne", "assets/UI/Pointers/04.png");
    this.load.image("selector-sw", "assets/UI/Pointers/05.png");
    this.load.image("selector-se", "assets/UI/Pointers/06.png");

    // Resources
    this.load.image("gold", "assets/Resources/Resources/G_Idle.png");
    this.load.image("action", "assets/Resources/Resources/M_Idle.png");
    this.load.image("wood", "assets/Resources/Resources/timber-x192.png");
    this.load.image(
      "runestone",
      "assets/Resources/Resources/runestone-x192.png",
    );
    this.load.image("tool", "assets/Resources/Resources/hammer-x192.png");
    this.load.image("fur", "assets/Resources/Resources/fur-x192.png");

    // Icons
    this.load.image("icon-gold", "assets/UI/Icons/coin.svg");
    this.load.image("icon-action", "assets/UI/Icons/compass.svg");
    this.load.image("icon-score", "assets/UI/Icons/crown.svg");
    this.load.image("icon-wood", "assets/Resources/Resources/timber-x64.png");
    this.load.image(
      "icon-runestone",
      "assets/Resources/Resources/runestone-x64.png",
    );
    this.load.image("icon-tool", "assets/Resources/Resources/hammer-x64.png");
    this.load.image("icon-fur", "assets/Resources/Resources/fur-x64.png");
    this.load.image("icon-close", "assets/UI/Icons/Regular_01.png");
    this.load.image("icon-one", "assets/UI/Icons/Regular_04.png");
    this.load.image("icon-two", "assets/UI/Icons/Regular_05.png");
    this.load.image("icon-three", "assets/UI/Icons/Regular_06.png");
    this.load.image("icon-four", "assets/UI/Icons/Regular_07.png");
    this.load.image("icon-five", "assets/UI/Icons/Regular_08.png");
    this.load.image("icon-left", "assets/UI/Icons/Regular_09.png");
    this.load.image("icon-right", "assets/UI/Icons/Regular_08.png");
    this.load.image("icon-close-pressed", "assets/UI/Icons/Pressed_01.png");
    this.load.image("icon-one-pressed", "assets/UI/Icons/Pressed_04.png");
    this.load.image("icon-two-pressed", "assets/UI/Icons/Pressed_05.png");
    this.load.image("icon-three-pressed", "assets/UI/Icons/Pressed_06.png");
    this.load.image("icon-four-pressed", "assets/UI/Icons/Pressed_07.png");
    this.load.image("icon-five-pressed", "assets/UI/Icons/Pressed_08.png");
    this.load.image("icon-left-pressed", "assets/UI/Icons/Pressed_09.png");
    this.load.image("icon-right-pressed", "assets/UI/Icons/Pressed_08.png");
    this.load.image("icon-close-disabled", "assets/UI/Icons/Disable_01.png");
    this.load.image("icon-left-disabled", "assets/UI/Icons/Disable_09.png");
    this.load.image("icon-right-disabled", "assets/UI/Icons/Disable_08.png");

    // Banners
    this.load.image("banner-h", "assets/UI/Banners/Banner_Horizontal.png");
    this.load.image(
      "banner-h-w6-h5",
      "assets/UI/Banners/Banner_Horizontal_6x5Slides.png",
    );
    this.load.image(
      "banner-h-left-w1-h16",
      "assets/UI/Banners/Banner_Horizontal_Left_1x16Slides.png",
    );
    this.load.image(
      "banner-h-right-w1-h16",
      "assets/UI/Banners/Banner_Horizontal_Right_1x16Slides.png",
    );
    this.load.image("banner-v", "assets/UI/Banners/Banner_Vertical.png");
    this.load.image(
      "banner-v-w4-h4",
      "assets/UI/Banners/Banner_Vertical_4x4Slides.png",
    );
    this.load.image(
      "banner-v-w7-h4",
      "assets/UI/Banners/Banner_Vertical_7x4Slides.png",
    );
    this.load.image(
      "banner-v-w7-h5",
      "assets/UI/Banners/Banner_Vertical_7x5Slides.png",
    );
    this.load.image(
      "banner-v-up-w7-h5",
      "assets/UI/Banners/Banner_Vertical_Up_7x5Slides.png",
    );
    this.load.image(
      "banner-v-down-w7-h5",
      "assets/UI/Banners/Banner_Vertical_Down_7x5Slides.png",
    );
    this.load.image(
      "banner-f-w7-h5",
      "assets/UI/Banners/Banner_Flat_7x5Slides.png",
    );
    this.load.image(
      "banner-left",
      "assets/UI/Banners/Banner_Connection_Left.png",
    );
    this.load.image(
      "banner-left-w3-h4",
      "assets/UI/Banners/Banner_Connection_Left_3x4Slides.png",
    );
    this.load.image(
      "banner-left-w4-h4",
      "assets/UI/Banners/Banner_Connection_Left_16Slides.png",
    );
    this.load.image(
      "banner-right-w3-h4",
      "assets/UI/Banners/Banner_Connection_Right_3x4Slides.png",
    );
    this.load.image(
      "banner-right-w4-h4",
      "assets/UI/Banners/Banner_Connection_Right_16Slides.png",
    );
    this.load.image("banner-up", "assets/UI/Banners/Banner_Connection_Up.png");
    this.load.image(
      "banner-up-w5-h3",
      "assets/UI/Banners/Banner_Connection_Up_5x3Slides.png",
    );
    this.load.image(
      "banner-up-w6-h3",
      "assets/UI/Banners/Banner_Connection_Up_6x3Slides.png",
    );
    this.load.image(
      "banner-up-w7-h3",
      "assets/UI/Banners/Banner_Connection_Up_7x3Slides.png",
    );
    this.load.image(
      "banner-b-w1-h16",
      "assets/UI/Banners/Banner_Band_1x16Slides.png",
    );
    this.load.image(
      "banner-b-w2-h16",
      "assets/UI/Banners/Banner_Band_2x16Slides.png",
    );

    // Carveds
    this.load.image("carved-w2-h1", "assets/UI/Banners/Carved_2x1Slides.png");
    this.load.image("carved-w3-h1", "assets/UI/Banners/Carved_3Slides.png");
    this.load.image("carved-w4-h1", "assets/UI/Banners/Carved_4Slides.png");
    this.load.image("carved-w5-h3", "assets/UI/Banners/Carved_5x3Slides.png");
    this.load.image("carved-w5-h2", "assets/UI/Banners/Carved_5x2Slides.png");
    this.load.image("carved-w2-h2", "assets/UI/Banners/Carved_2x2Slides.png");
    this.load.image("carved-w1-h1", "assets/UI/Banners/Carved_Regular.png");

    // Ribbons
    this.load.image(
      "ribbon-w3-h1-blue",
      "assets/UI/Ribbons/Ribbon_Blue_3Slides.png",
    );
    this.load.image(
      "ribbon-w4-h1-blue",
      "assets/UI/Ribbons/Ribbon_Blue_4Slides.png",
    );
    this.load.image(
      "ribbon-w1-blue-right",
      "assets/UI/Ribbons/Ribbon_Blue_Connection_Right.png",
    );
    this.load.image(
      "ribbon-w1-blue-left",
      "assets/UI/Ribbons/Ribbon_Blue_Connection_Left.png",
    );
    this.load.image(
      "ribbon-w1-blue-up",
      "assets/UI/Ribbons/Ribbon_Blue_Connection_Up.png",
    );
    this.load.image(
      "ribbon-w1-blue-down-start",
      "assets/UI/Ribbons/Ribbon_Blue_Connection_Down_Start.png",
    );
    this.load.image(
      "ribbon-w1-blue-up-start",
      "assets/UI/Ribbons/Ribbon_Blue_Connection_Up_Start.png",
    );
    this.load.image(
      "ribbon-w4-h1-red",
      "assets/UI/Ribbons/Ribbon_Red_4Slides.png",
    );
    this.load.image(
      "ribbon-w4-h1-yellow",
      "assets/UI/Ribbons/Ribbon_Yellow_4Slides.png",
    );
    this.load.image(
      "ribbon-w5-h1-yellow",
      "assets/UI/Ribbons/Ribbon_Yellow_5Slides.png",
    );
    this.load.image(
      "ribbon-w7-h1-yellow",
      "assets/UI/Ribbons/Ribbon_Yellow_7Slides.png",
    );
    this.load.image(
      "ribbon-w9-h1-yellow",
      "assets/UI/Ribbons/Ribbon_Yellow_9Slides.png",
    );
    this.load.image(
      "ribbon-w1-yellow-right",
      "assets/UI/Ribbons/Ribbon_Yellow_Connection_Right.png",
    );
    this.load.image(
      "ribbon-w1-yellow-left",
      "assets/UI/Ribbons/Ribbon_Yellow_Connection_Left.png",
    );
    this.load.image(
      "ribbon-w1-yellow-left-pressed",
      "assets/UI/Ribbons/Ribbon_Yellow_Connection_Left_Pressed.png",
    );
    this.load.image(
      "ribbon-w1-yellow-up",
      "assets/UI/Ribbons/Ribbon_Yellow_Connection_Up.png",
    );
    this.load.image(
      "ribbon-w1-yellow-up-pressed",
      "assets/UI/Ribbons/Ribbon_Yellow_Connection_Up_Pressed.png",
    );

    // Buttons
    this.load.image("button-w1-h1-blue", "assets/UI/Buttons/Button_Blue.png");
    this.load.image(
      "button-w1-h1-blue-pressed",
      "assets/UI/Buttons/Button_Blue_Pressed.png",
    );
    this.load.image("button-w1-h1-red", "assets/UI/Buttons/Button_Red.png");
    this.load.image(
      "button-w1-h1-red-pressed",
      "assets/UI/Buttons/Button_Red_Pressed.png",
    );
    this.load.image("button-w1-h1-hover", "assets/UI/Buttons/Button_Hover.png");
    this.load.image(
      "button-w1-h1-disabled",
      "assets/UI/Buttons/Button_Disable.png",
    );
    this.load.image(
      "button-w3-h1-blue",
      "assets/UI/Buttons/Button_Blue_3Slides.png",
    );
    this.load.image(
      "button-w3-h1-blue-pressed",
      "assets/UI/Buttons/Button_Blue_3Slides_Pressed.png",
    );
    this.load.image(
      "button-w3-h1-red",
      "assets/UI/Buttons/Button_Red_3Slides.png",
    );
    this.load.image(
      "button-w3-h1-red-pressed",
      "assets/UI/Buttons/Button_Red_3Slides_Pressed.png",
    );
    this.load.image(
      "button-w3-h1-hover",
      "assets/UI/Buttons/Button_Hover_3Slides.png",
    );
    this.load.image(
      "button-w3-h1-disabled",
      "assets/UI/Buttons/Button_Disable_3Slides.png",
    );
    this.load.image(
      "button-w3-h3-blue",
      "assets/UI/Buttons/Button_Blue_9Slides.png",
    );
    this.load.image(
      "button-w3-h3-blue-pressed",
      "assets/UI/Buttons/Button_Blue_9Slides_Pressed.png",
    );
    this.load.image(
      "button-w3-h3-red",
      "assets/UI/Buttons/Button_Red_9Slides.png",
    );
    this.load.image(
      "button-w3-h3-red-pressed",
      "assets/UI/Buttons/Button_Red_9Slides_Pressed.png",
    );
    this.load.image(
      "button-w3-h3-hover",
      "assets/UI/Buttons/Button_Hover_9Slides.png",
    );
    this.load.image(
      "button-w3-h3-disabled",
      "assets/UI/Buttons/Button_Disable_9Slides.png",
    );

    // Buildings
    this.load.image(
      "building-house-blue",
      "assets/Factions/Knights/Buildings/House/House_Blue.png",
    );
    this.load.image(
      "building-house-construction",
      "assets/Factions/Knights/Buildings/House/House_Construction.png",
    );
    this.load.image(
      "building-castle-blue",
      "assets/Factions/Knights/Buildings/Castle/Castle_Blue.png",
    );
    this.load.image(
      "building-castle-construction",
      "assets/Factions/Knights/Buildings/Castle/Castle_Construction.png",
    );

    // Troops
    this.load.spritesheet(
      "pawn-blue",
      "assets/Factions/Knights/Troops/Pawn/Blue/Pawn_Blue.png",
      {
        frameWidth: 192,
        frameHeight: 192,
      },
    );
    this.load.spritesheet(
      "pawn-purple",
      "assets/Factions/Knights/Troops/Pawn/Purple/Pawn_Purple.png",
      {
        frameWidth: 192,
        frameHeight: 192,
      },
    );
    this.load.spritesheet(
      "pawn-red",
      "assets/Factions/Knights/Troops/Pawn/Red/Pawn_Red.png",
      {
        frameWidth: 192,
        frameHeight: 192,
      },
    );
    this.load.spritesheet(
      "pawn-yellow",
      "assets/Factions/Knights/Troops/Pawn/Yellow/Pawn_Yellow.png",
      {
        frameWidth: 192,
        frameHeight: 192,
      },
    );
  }

  create() {
    // Managers
    AnimationManager.getInstance().addAnimations(this);
    AudioManager.getInstance().addSounds(this);

    // Start soundtracks
    AudioManager.play(this, "theme-menu", true);

    // Start scene
    this.scene.start("Menu");
  }
}
