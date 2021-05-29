#include "cryptocontroller.h"
#include <QDebug>
#include <QFile>
#include <QUrl>
#include <QFileInfo>
//#include <QProcess>
#include <QDesktopServices>

void CryptoController::handleErrors(void)  //проверка на ошибки openssl
{
    unsigned long e = ERR_get_error(); //длина
    char buf[1024]; //в буфер след функция возвращает текст ошибки по числовому коду
    QString eStr( ERR_error_string(e, buf) );
    emit showMessage(eStr);
}


CryptoController::CryptoController(QObject *parent) : QObject(parent)
{
}


QString CryptoController::plainName(const QString& inFile)
{
    //return inFile;
    return QUrl(inFile).toLocalFile();
}


QString CryptoController::encName(const QString& inFile)
{
    int pos = inFile.lastIndexOf('.');
    if (pos < 0)
        return inFile + "_enc";
    else
        return inFile.left(pos) + "_enc" + inFile.mid(pos);
}


QString CryptoController::decName(const QString& inFile)
{
    int pos = inFile.lastIndexOf('.');
    if (pos < 0)
        return inFile + "_dec";
    else
        return inFile.left(pos) + "_dec" + inFile.mid(pos);
}



void CryptoController::cryptFile(const QString& inKey, const QString& inFile, const QString& outFile, int mode)
{
    QFile fp( inFile );

    if (!fp.open(QFile::ReadOnly)) {
        emit showMessage("Can`t open file " + inFile);
        return;
    }

    QFile fe( outFile );

    if (!fe.open(QFile::WriteOnly)) {
        emit showMessage("Can`t open file " + outFile);
        return;
    }

    /* A 256 bit key */
    QByteArray qKey = inKey.toLocal8Bit();
    unsigned char *key = (unsigned char *)(qKey.data());        // = (unsigned char *)"01234567890123456789012345678901";

    /* A 128 bit IV */
    unsigned char *iv = (unsigned char *)"0123456789012345";


    EVP_CIPHER_CTX *ctx;  //ctx это указатель на контекст
    int len;

    /* Проверка успеха создания и инициализации контекста*/
    if(!(ctx = EVP_CIPHER_CTX_new())) {
        handleErrors();
        return;
    }

    if(1 != EVP_CipherInit_ex(ctx, EVP_aes_256_cbc(), NULL, key, iv, mode)) {
        handleErrors();
        return;
    }

    int bs = EVP_CIPHER_CTX_block_size(ctx);

    const int buf_size = 512;

    QByteArray out_data(buf_size + bs, 0);
    QByteArray in_data;

    while (true) {                    //в цикле шифруем по кусочкам, в соответствии с выбранным размерам буфера
        in_data = fp.read(buf_size);

        if (in_data.length() == 0)
            break;

        if(1 != EVP_CipherUpdate(ctx, (unsigned char *)(out_data.data()), &len, (unsigned char *)(in_data.data()), in_data.length())) {
            handleErrors();
            return;
        }

        out_data.truncate(len);
        fe.write(out_data);
        out_data.resize(buf_size + bs); //!!!
    }

    //финальная процедура шифрования

    if(1 != EVP_CipherFinal_ex(ctx, (unsigned char *)(out_data.data()), &len)) {
        handleErrors();
        return;
    }

    /* удаляем контекст и закрываем файлы */
    out_data.truncate(len);

    fe.write(out_data);

    fp.close();
    fe.close();


    EVP_CIPHER_CTX_free(ctx);
}


void CryptoController::encryptFile(const QString& inKey, const QString& inFile) //(QString key1, QString in, QString out)
{
    QString inF = plainName(inFile);
    QString outF = encName(inF);

    showMessage(inF + "         " + outF);
    cryptFile(inKey, inF, outF, 1);
}


void CryptoController::decryptFile(const QString& inKey, const QString& inFile)
{
    QString inF = encName(plainName(inFile));
    QString outF = decName(inF);

    cryptFile(inKey, inF, outF, 0);
}


void CryptoController::showFile(const QString& inFile, const int& mode)
{
    switch (mode){
    case 0:
        QDesktopServices::openUrl(inFile);
        QDesktopServices::openUrl(encName(inFile));
        break;
    case 1:
        QDesktopServices::openUrl(encName(inFile));
        break;
    case 2:
        QDesktopServices::openUrl(decName(encName(inFile)));
        break;
    }
}

