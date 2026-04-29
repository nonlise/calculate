pragma Singleton

import QtQuick

QtObject {
   readonly property QtObject colors: QtObject {
      readonly property color theme_1_1: "#024873"
      readonly property color theme_1_2: "#0889A6"
      readonly property color theme_1_3: "#04BFAD"
      readonly property color theme_1_4: "#B0D1D8"
      readonly property color theme_1_5: "#F25E5E"
      readonly property color theme_1_6: "#FFFFFF"

      readonly property color theme_1_add_1: "#00F79C"
      readonly property color theme_1_add_2: "#F7E425"

      readonly property color settingBackground: "black"
      readonly property color settingText: "white"
   }

   readonly property QtObject sizeCalculator: QtObject {
      readonly property int width: 360
      readonly property int height: 640
   }

   readonly property QtObject sizeButtons: QtObject {
      readonly property int width: 60
      readonly property int height: width
   }


   readonly property QtObject spaces: QtObject {
      readonly property int common: 24
   }
}
