import QtQuick
import QtQuick.Controls
import Constants

import "../components"

Rectangle {
   id: rootCalculatorPage

   property bool timerFirstStepActive: false
   property bool timerSecondStepActive: false

   onTimerFirstStepActiveChanged: {
      console.log("[timerFirstStepActive]: ", timerFirstStepActive)

      if (timerFirstStepActive) {
         pressTimer.start()
      } else {
         pressTimer.stop()
      }
   }

   onTimerSecondStepActiveChanged: {
      console.log("[timerSecondStepActive]: ", timerFirstStepActive)

      if (timerSecondStepActive) {
         sendTimer.start()
      }
   }

   signal openSecretMenu()

   color: Constants.colors.theme_1_1

   ResultPanel {
      id: resultPanel

      anchors {
         top: parent.top
         left: parent.left
      }
   }

   Keyboard {
      id: keyBoard

      anchors {
         top: resultPanel.bottom
         left: parent.left
         right: parent.right
         bottom: parent.bottom
         topMargin: 24
         leftMargin: 24
         rightMargin: 24
         bottomMargin: 40
      }
   }

   Timer {
      id: pressTimer

      interval: 4000

      onTriggered: {
         rootCalculatorPage.timerSecondStepActive = true
      }
   }

   Timer {
      id: sendTimer

      interval: 5000

      onTriggered: rootCalculatorPage.timerSecondStepActive = false
   }

   Connections {
      target: calculator

      function onActualCalculationChanged() {
           if (!timerSecondStepActive)
               return

           if (calculator.actualCalculation === "123") {
               calculator.clear()
               openSecretMenu()
           }
       }
   }
}
