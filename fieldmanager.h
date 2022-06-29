#ifndef FIELDMANAGER_H
#define FIELDMANAGER_H

#include <QObject>
#include <QQmlEngine>

class FieldManager : public QObject
{
    Q_OBJECT;
public:

    Q_PROPERTY(QString text READ getText WRITE setText NOTIFY textChanged)

    static FieldManager* instance();

    const QString& getText() const;

    static void registerType() {
        qmlRegisterSingletonInstance<FieldManager>("FieldManager", 1, 0, "FieldManager",
                                                   FieldManager::instance());
    }

public slots:
    void setText(const QString& text);

signals:
    void textChanged(const QString& text);

private:
    FieldManager();
    ~FieldManager();
    FieldManager(const FieldManager&);
    FieldManager& operator=(const FieldManager&);

    QString m_text = "default";
};

#endif // FIELDMANAGER_H
