#include "Calculator.h"

#include <QDebug>

Calculator::Calculator(QObject *parent)
    : QObject(parent)
    , m_actualCalculation("0")
{
}

void Calculator::setActualCalculation(const QString &value)
{
    if (m_actualCalculation.length() > 25) {
        qWarning() << "[калькулятор] Превышено допустимое кол. символов";
        return;
    }


    if (value == "") {
        qWarning() << "[калькулятор] Пришло пустое значение";
        return;
    }

    const int lengthC = m_actualCalculation.length();

    if (lengthC == 1 && m_actualCalculation[lengthC - 1] == '0') {
        m_actualCalculation = value;
    } else {
        m_actualCalculation += value;
    }

    emit actualCalculationChanged();
}

void Calculator::clear()
{
    m_actualCalculation = "0";
    emit actualCalculationChanged();
}

void Calculator::plus()
{
    m_actualCalculation += "+";
    emit actualCalculationChanged();
}

void Calculator::minus()
{
    m_actualCalculation += "-";
    emit actualCalculationChanged();
}

void Calculator::round_Bracket()
{
    int countOpen = 0;
    int countClose = 0;

    for (const auto i : m_actualCalculation) {
        if (i == "(") countOpen += 1;
        if (i == ")") countClose += 1;
    }

    if (countOpen > countClose) {
        m_actualCalculation += ")";
    } else {
        m_actualCalculation += "(";
    }

    emit actualCalculationChanged();
}

void Calculator::dot()
{
    m_actualCalculation += ".";
    emit actualCalculationChanged();
}

void Calculator::multiplication()
{
    m_actualCalculation += "*";
    emit actualCalculationChanged();
}

void Calculator::percent()
{
    m_actualCalculation += "%";
    emit actualCalculationChanged();
}

void Calculator::division()
{
    m_actualCalculation += "/";
    emit actualCalculationChanged();
}

void Calculator::convertPlus_Minus()
{
    if (m_actualCalculation.isEmpty() || m_actualCalculation == "0") {
        return;
    }

    int i = m_actualCalculation.length() - 1;

    while (i >= 0 && m_actualCalculation[i].isSpace()) {
        i--;
    }

    bool foundDigit = false;
    while (i >= 0) {
        QChar ch = m_actualCalculation[i];

        if (ch.isDigit() || ch == '.') {
            foundDigit = true;
            i--;
        } else if (ch == '-' || ch == '+') {
            if (foundDigit || (i + 1 < m_actualCalculation.length() &&
                               (m_actualCalculation[i + 1].isDigit() || m_actualCalculation[i + 1] == '.'))) {
                if (ch == '-') {
                    m_actualCalculation[i] = '+';
                } else {
                    m_actualCalculation[i] = '-';
                }
                emit actualCalculationChanged();
                return;
            }
            break;
        }
        else {
            break;
        }
    }

    int insertPos = i + 1;

    if (insertPos > 0 && m_actualCalculation[insertPos - 1] == '-') {
        m_actualCalculation.remove(insertPos - 1, 1);
    } else {
        m_actualCalculation.insert(insertPos, '-');
    }

    emit actualCalculationChanged();
}

double Calculator::parseNumber(const QString &expr, int &pos)
{
    QString numStr;
    bool hasDot = false;

    while (pos < expr.length() && (expr[pos].isDigit() || expr[pos] == '.')) {
        if (expr[pos] == '.') {
            if (hasDot) break;
            hasDot = true;
        }
        numStr += expr[pos];
        pos++;
    }

    return numStr.toDouble();
}

double Calculator::parseFactor(const QString &expr, int &pos)
{
    if (pos >= expr.length()) return 0;

    if (expr[pos] == '(') {
        pos++;

        double result = parseExpression(expr, pos);
        if (pos < expr.length() && expr[pos] == ')') {
            pos++;
        }

        return result;
    }

    if (expr[pos] == '+') {
        pos++;
        return parseFactor(expr, pos);
    }

    if (expr[pos] == '-') {
        pos++;
        return -parseFactor(expr, pos);
    }

    return parseNumber(expr, pos);
}

double Calculator::parseTerm(const QString &expr, int &pos)
{
    double result = parseFactor(expr, pos);

    while (pos < expr.length()) {
        QChar op = expr[pos];
        if (op == '*' || op == '/' || op == '%') {
            pos++;
            double nextValue = parseFactor(expr, pos);

            if (op == '*') {
                result *= nextValue;
            } else if (op == '/') {
                if (nextValue != 0) {
                    result /= nextValue;
                } else {
                    qWarning() << "[калькулятор] Деление на ноль!";
                    m_actualCalculation = "0";
                    emit actualCalculationChanged();
                    return 0;
                }
            } else if (op == '%') {
                result = std::fmod(result, nextValue);
            }
        } else {
            break;
        }
    }

    return result;
}

double Calculator::parseExpression(const QString &expr, int &pos)
{
    double result = parseTerm(expr, pos);

    while (pos < expr.length()) {
        QChar op = expr[pos];
        if (op == '+' || op == '-') {
            pos++;
            double nextValue = parseTerm(expr, pos);

            if (op == '+') {
                result += nextValue;
            } else {
                result -= nextValue;
            }
        } else {
            break;
        }
    }

    return result;
}

void Calculator::equal()
{
    if (m_actualCalculation.isEmpty() || m_actualCalculation == "0") {
        return;
    }

    QString expression = m_actualCalculation;

    int pos = 0;
    double result = parseExpression(expression, pos);

    while (pos < expression.length() && !expression[pos].isPrint()) {
        pos++;
    }

    if (pos < expression.length()) {
        qWarning() << "[калькулятор] Ошибка в выражении на позиции" << pos;
        // NOTE: Думаю очищать не нужно
        return;
    }

    QString resultStr;
    if (std::abs(result - std::round(result)) < 1e-10) {
        resultStr = QString::number(static_cast<long long>(result));
    } else {
        resultStr = QString::number(result, 'f', 10);
        while (resultStr.endsWith('0')) resultStr.chop(1);
        if (resultStr.endsWith('.')) resultStr.chop(1);
    }

    m_historyOperation = m_actualCalculation;
    emit historyOperationChanged();

    m_actualCalculation = resultStr;
    emit actualCalculationChanged();
}
