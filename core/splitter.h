#ifndef SPLITTER_H
#define SPLITTER_H
#include <string>

std::string getSubstring(std::string& word, size_t& pos, char delimiter)
{
    pos = word.find(delimiter);
    std::string substring = word.substr(0, pos);
    word.erase(0, pos+1);
    return substring;
}

#endif // SPLITTER_H
