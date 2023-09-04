#ifndef NODEEXCEPTION_H
#define NODEEXCEPTION_H

#include <QString>

class NodeException {

public:
   NodeException(const QString& msg) : msg_(msg) {}
  ~NodeException() {}
   QString getMessage() const {return(msg_);}
private:
   QString msg_;
};

#endif // NODEEXCEPTION_H
