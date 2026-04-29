import QtQuick
import QtQuick.Layouts

GridLayout {
    id: rootKeyBoard

    function getIconByType(typeValue) {
        const basePath = "qrc:/icons/"

        const icons = {
            "round_bracket": "bkt.svg",
            "plus_minus": "plus_minus.svg",
            "percent": "percent.svg",
            "division": "division.svg",
            "multiplication": "multiplication.svg",
            "minus": "minus.svg",
            "plus": "plus.svg",
            "equal": "equal.svg"
        }

        return icons[typeValue] ? basePath + icons[typeValue] : ""
    }

    columns: 4
    rows: 5
    rowSpacing: Constants.spaces.common
    columnSpacing: Constants.spaces.common

    Repeater {
        model: ListModel {
            ListElement { type: "round_bracket" }
            ListElement { type: "plus_minus" }
            ListElement { type: "percent" }
            ListElement { type: "division" }

            ListElement { type: "number"; value: 7 }
            ListElement { type: "number"; value: 8 }
            ListElement { type: "number"; value: 9 }
            ListElement { type: "multiplication" }

            ListElement { type: "number"; value: 4 }
            ListElement { type: "number"; value: 5 }
            ListElement { type: "number"; value: 6 }
            ListElement { type: "minus" }

            ListElement { type: "number"; value: 1 }
            ListElement { type: "number"; value: 2 }
            ListElement { type: "number"; value: 3 }
            ListElement { type: "plus" }

            ListElement { type: "clear" }
            ListElement { type: "number"; value: 0 }
            ListElement { type: "dot" }
            ListElement { type: "equal" }
        }

        Key {
            Layout.fillWidth: true
            Layout.fillHeight: true

            isClear: type === "clear"
            labelValue: {
                if (type === "dot")
                    return "."

                if (type === "clear")
                    return "C"

                if (type === "number")
                    return value

                return ""
            }

            iconSrc: type !== "dot" && type !== "number"
                     ? getIconByType(type)
                     : ""


            onKeyClicked: {
                if (type === "number") {
                    calculator.actualCalculation = value;
                }

                if (type === "clear") {
                    calculator.clear()
                }

                if (type === "dot") {
                    calculator.dot()
                }

                if (type === "plus") {
                    calculator.plus()
                }

                if (type === "minus") {
                    calculator.minus()
                }

                if (type === "multiplication") {
                    calculator.multiplication()
                }

                if (type === "percent") {
                    calculator.percent()
                }

                if (type === "division") {
                    calculator.division()
                }

                if (type === "round_bracket") {
                    calculator.round_Bracket()
                }

                if (type === "plus_minus") {
                    calculator.convertPlus_Minus()
                }

                if (type === "equal") {
                    calculator.equal()
                }
            }

            onKeyPressed: function(pressed) {
                if (type === "equal") {
                    rootCalculatorPage.timerFirstStepActive = pressed
                }
            }
        }
    }
}
