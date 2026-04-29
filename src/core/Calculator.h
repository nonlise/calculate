#ifndef CALCULATOR_H
#define CALCULATOR_H

#include <QObject>
#include <QString>
#include <QChar>
#include <QVariant>
#include <QMap>

class Calculator : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString actualCalculation READ actualCalculation WRITE setActualCalculation NOTIFY actualCalculationChanged)
    Q_PROPERTY(QString historyOperation READ historyOperation NOTIFY historyOperationChanged)

public:
    explicit Calculator(QObject *parent = nullptr);

    [[nodiscard]] QString actualCalculation() const { return m_actualCalculation; }
    [[nodiscard]] QString historyOperation() const { return m_historyOperation; }

    void setActualCalculation(const QString &value);

    Q_INVOKABLE void convertPlus_Minus();
    Q_INVOKABLE void clear();
    Q_INVOKABLE void equal();
    Q_INVOKABLE void plus();
    Q_INVOKABLE void minus();
    Q_INVOKABLE void round_Bracket();
    Q_INVOKABLE void dot();
    Q_INVOKABLE void multiplication();
    Q_INVOKABLE void percent();
    Q_INVOKABLE void division();

signals:
    void actualCalculationChanged();
    void historyOperationChanged();

private:
    double parseExpression(const QString &expr, int &pos);
    double parseTerm(const QString &expr, int &pos);
    double parseFactor(const QString &expr, int &pos);
    double parseNumber(const QString &expr, int &pos);

private:
    QString m_actualCalculation;
    QString m_historyOperation;
};

#endif // CALCULATOR_H
