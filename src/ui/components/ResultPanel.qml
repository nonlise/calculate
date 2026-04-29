import QtQuick
import QtQuick.Layouts

Rectangle {
    height: 180
    width: parent.width
    color: Constants.colors.theme_1_3

    bottomLeftRadius: 32
    bottomRightRadius: 32

    Text {
        id: actualCalculationText

        anchors {
            bottom: parent.bottom
            left: parent.left
            right: parent.right
            leftMargin: 39
            rightMargin: 40
            bottomMargin: 14
        }

        text: calculator.actualCalculation
        color: "white"
        horizontalAlignment: Text.AlignRight
        font.pixelSize: 50
    }

    Text {
        anchors {
            bottom: actualCalculationText.top
            left: parent.left
            right: parent.right
            leftMargin: 39
            rightMargin: 41
            bottomMargin: 8
        }

        text: calculator.historyOperation
        color: "white"
        horizontalAlignment: Text.AlignRight
        font.pixelSize: 20
    }
}
