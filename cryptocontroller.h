#ifndef CRYPTOCONTROLLER_H
#define CRYPTOCONTROLLER_H

#include <openssl/conf.h>
#include <openssl/evp.h>
#include <openssl/err.h>

#include <QObject>
#include <QDebug>



class CryptoController : public QObject
{
    Q_OBJECT

private:
    QString plainName(const QString& inFile);
    QString encName(const QString& inFile);
    QString decName(const QString& inFile);

public:
    explicit CryptoController(QObject *parent = nullptr);
    void handleErrors(void);
    void cryptFile(const QString& inKey, const QString& inFile, const QString& outFile, int mode);

signals:
    void showMessage(QVariant text);

public slots:
    void encryptFile(const QString& inKey, const QString& inFile);
    void decryptFile(const QString& inKey, const QString& inFile);

    void showFile(const QString& inFile, const int& mode);
};

#endif // CRYPTOCONTROLLER_H
