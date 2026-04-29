import QtQuick
import QtQuick.Layouts

Rectangle {
   id: rootKey

   property alias iconSrc: imageKey.source
   property alias labelValue: textKey.text

   property color _rectColorByImage: mouseAreaKey.pressed
                                     ? Constants.colors.theme_1_add_2
                                     : Constants.colors.theme_1_2
   property color _rectColorByText: mouseAreaKey.pressed
                                    ? Constants.colors.theme_1_3
                                    : Constants.colors.theme_1_4

   property bool isClear: false

   signal keyClicked()
   signal keyPressed(var statusPressed)

   width: Constants.sizeButtons.width
   height: Constants.sizeButtons.height
   radius: height * 0.5
   color: isClear
          ? Constants.colors.theme_1_6
          : imageKey.visible
            ? _rectColorByImage
            : _rectColorByText

   Rectangle {
      anchors.fill: parent
      visible: rootKey.isClear
      radius: rootKey.radius
      color: Constants.colors.theme_1_5
      opacity: mouseAreaKey.pressed ? 1.0 : 0.5
   }

   Image {
      id: imageKey

      anchors.centerIn: parent
      width: 30
      height: 30
      source: rootKey.iconSrc
      visible: status == Image.Ready
   }

   Text {
      id: textKey

      anchors.centerIn: parent
      visible: !imageKey.visible
      color: mouseAreaKey.pressed || rootKey.isClear
             ? Constants.colors.theme_1_6
             : Constants.colors.theme_1_1
      font.pixelSize: 24
   }

   MouseArea {
      id: mouseAreaKey

      anchors.fill: parent

      onClicked: keyClicked()
      onPressed: keyPressed(true)
      onReleased: keyPressed(false)
   }
}
