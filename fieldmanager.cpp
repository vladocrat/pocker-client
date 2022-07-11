#include "fieldmanager.h"

#include <QDebug>

FieldManager::FieldManager()
{
    qDebug() << Q_FUNC_INFO;
}

FieldManager::~FieldManager()
{

}

FieldManager* FieldManager::instance()
{
    static FieldManager manager;
    return &manager;
}

const QString& FieldManager::getText() const
{
    qDebug() << Q_FUNC_INFO;
    return m_text;
}

void FieldManager::setText(const QString &text)
{
    m_text = text;
    emit textChanged(m_text);
}
