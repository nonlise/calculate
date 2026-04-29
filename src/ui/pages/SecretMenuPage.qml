import QtQuick
import QtQuick.Controls
import Constants

Rectangle {
   signal goBack()

   color: Constants.colors.settingBackground

   Column {
      anchors.centerIn: parent
      width: parent.width - 40
      spacing: 10

      Label {
         anchors.horizontalCenter: parent.horizontalCenter
         text: "Секретное меню"
         color: Constants.colors.settingText
         font.pixelSize: 19
      }

      Rectangle {
         width: parent.width
         height: 50
         radius: 15
         color: mouseArea.pressed
                ? Constants.colors.theme_1_1
                : Constants.colors.theme_1_2

         Label {
            anchors.centerIn: parent
            text: "Выйти назад"
            color: Constants.colors.settingText
            font.pixelSize: 16
         }

         MouseArea {
            id: mouseArea

            anchors.fill: parent

            onPressed: goBack()
         }
      }
   }
}
