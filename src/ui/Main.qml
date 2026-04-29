import QtQuick
import QtQuick.Controls
import Constants

import "pages"

Window {
    width: stackView.width
    height: stackView.height
    visible: true

    StackView {
        id: stackView
        anchors.centerIn: parent
        width: Constants.sizeCalculator.width
        height: Constants.sizeCalculator.height
        initialItem: componentCalculator
    }

    Component {
        id: componentSecret

        SecretMenuPage {
            onGoBack: stackView.pop()
        }
    }

    Component {
        id: componentCalculator

        CalculatorPage {
            onOpenSecretMenu: stackView.push(componentSecret)
        }
    }
}
