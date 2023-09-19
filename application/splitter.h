#ifndef SPLITTER_H
#define SPLITTER_H
#include <string>

std::string popSubstring(std::string& word, char delimiter){
    size_t pos = word.find(delimiter);
    std::string substring = word.substr(0, pos);
    word.erase(0, pos+1);
    return substring;
}

#endif // SPLITTER_H
